Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F762EEE7C
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823531; cv=none; b=jt2+iwQjiW1/DgVWQ6mpvzq+N5VcsU3jC4HsrX4uDc32v25Q0WwH576yN3u5la2jyZ2FxW7+1u858wiYZAO8s+XaUE+IponbLlLRRi4MPTEASD8aQ19Iu/j2QbbGi9kLA4GCzofgrXUblksUlJ050RDQB+wIbA2n5sbX/DcTlxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823531; c=relaxed/simple;
	bh=8WsxD8iajB0xkgIcyl6w7A2v2BhQ7WHBgPbhvKZrbO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkHX0E3opp5IKxYmttLk1lVnlKNwj9ymY6bN7qVOCs/IgT0NAZqIgWwW9UvmbnA77BO0zRNsss0O6nKzvsm7fOhm/5Acqam7I1D+UxVyOABayTh8ej/mMGE1zidnHIUPf4g2iN5oXkjGp7XszrTD3SaQb0HfJjw45kookQ6+/jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from localhost (bharat.asicdesigners.com [10.193.191.25])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 69CGhgkc016512;
	Mon, 12 Oct 2026 09:43:43 -0700
Date: Mon, 12 Oct 2026 22:13:21 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v3 02/12] cxgb4: rework the interrupt handling
 framework
Message-ID: <as0OKd7jR1j/tB1L@chelsio.com>
References: <20261005224830.377752-1-bharat@chelsio.com>
 <20261005224830.377752-3-bharat@chelsio.com>
 <20261009135613.GC83879@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009135613.GC83879@horms.kernel.org>

On Friday, October 10/09/26, 2026 at 19:26:13 +0530, Simon Horman wrote:
> On Mon, Oct 05, 2026 at 06:48:20PM -0400, Potnuri Bharat Teja wrote:
> > The slow interrupt path used a per module handler that walked a table
> > of (mask, message) pairs with t4_handle_intr_status() and printed a
> > message for every bit it found set.  Each module handler open coded
> > the read, report and clear sequence, and there was no way to express
> > that a cause bit should be handled by inspecting a sub-register, or
> > that a bit is only fatal when it is also enabled.
> > 
> > Replace it with a data driven framework:
> > 
> >   struct intr_info describes one cause register: its name, the cause
> >   and enable register offsets, the mask of fatal bits, a table of
> >   struct intr_details for decoding individual bits, and an optional
> >   table of struct intr_action entries naming a function to call for a
> >   given cause bit.
> > 
> >   t4_handle_intr() implements the common read, report, dispatch and
> >   clear sequence once, so a module handler reduces to describing its
> >   registers and any nested cause registers it owns.
> > 
> > The module interrupt handlers now return bool rather than void so a
> > fatal condition propagates back to t4_slow_intr_handler() instead of
> > being signalled out of band, and t4_slow_intr_handler() takes a
> > verbose flag controlling whether individual cause bits are decoded
> > and logged.
> > 
> > This changes the interrupt path for all supported adapters.  No
> > functional change is intended for T4, T5 or T6 beyond the wording of
> > the messages emitted.
> > 
> > Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> 
> Hi Potnuri,
> 
> Thanks for your patch.
> 
> x86_64 allmodconfig W=1 builds with clang 22.1.8 warn that:
> 
>   .../t4_hw.c:6959:3: warning: variable 'fatal' is uninitialized when used here [-Wuninitialized]
>    6959 |                 fatal |= t4_handle_intr(adap, &ii, 0, verbose);
>         |                 ^~~~~
>   .../t4_hw.c:6945:12: note: initialize the variable 'fatal' to silence this warning
>    6945 |         bool fatal;
>         |                   ^
>         |                    = 0
>   1 warning generated.
>   Warning: .../t4_hw.c:7956 function parameter 'adap' not described in 't4_slow_intr_handler'
>   Warning: .../t4_hw.c:7956 Excess function parameter 'adapter' description in 't4_slow_intr_handler' (did you mean one of: 'adap')
>   Warning: .../t4_hw.c:8209 function parameter 'adap' not described in 't4_intr_enable'
>   Warning: .../t4_hw.c:8209 Excess function parameter 'adapter' description in 't4_intr_enable' (did you mean one of: 'adap')
>   Warning: .../t4_hw.c:7956 function parameter 'adap' not described in 't4_slow_intr_handler'
>   Warning: .../t4_hw.c:7956 Excess function parameter 'adapter' description in 't4_slow_intr_handler' (did you mean one of: 'adap')
>   Warning: .../t4_hw.c:8209 function parameter 'adap' not described in 't4_intr_enable'
>   Warning: .../t4_hw.c:8209 Excess function parameter 'adapter' description in 't4_intr_enable' (did you mean one of: 'adap')
> 
> Similarly building patch 3/12, 5/12, 10/12, and 11/12,
> seem to add new warnings reported by gcc 16.2.1 or clang.
> 
> Please make sure your patch compiles for x86_64 allmodconfig W=1
> with out new warnings emitted by either gcc or clang.
> 
> 
> The following functions added in .c files use the inline keyword.
> 
>   static inline char intr_alert_char(u32 cause, u32 enable, u32 fatal)
>   static inline u32 t7_tlstx_reg(u8 instance, u8 channel, u32 reg)
>   static inline uint32_t
> 
> Please don't use inline like that, instead please let the compiler
> choose to inline functions (or not).
> 
> inline functions in .h files are of course fine.
>

Shall send revised patches with above fixes. 
> 
> And checkpatch reports the following errors for patch 4/12.
> 
>   ERROR: missing sentinel in ID array
>   #1734: FILE: drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.c:289:
>   +static const struct pci_device_id cxgb4_pci_tbl[] = {
>    #define CH_PCI_DEVICE_ID_FUNCTION CXGB4_UNIFIED_PF
>    #define CH_PCI_DEVICE_ID_FUNCTION2 0x0
> 
>    #define CH_PCI_ID_TABLE_ENTRY(devid) \
> 	{ PCI_VDEVICE(CHELSIO, (devid)), CXGB4_UNIFIED_PF }
> 
>    #define CH_PCI_DEVICE_ID_TABLE_DEFINE_END \
> 	{ 0, } \
>    }
> 
>   ERROR: Macros with complex values should be enclosed in parentheses
>   #1741: FILE: drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.c:296:
>   +#define CH_PCI_DEVICE_ID_TABLE_DEFINE_END \
>   +	{ 0, } \
>   +}
> 
> Please make sure the patchset does not add checkpatch errors.

The above warning is a false positive. I have left these check patch warnings as is the patch only 
moves the older code to a new file but introduce any new warnings. Ideally this can be fixed by 
removing the unwanted # define wrappers. However that needs that same changes needs to be done in csiostor 
driver as well. Therefore i left them as is to confine the current serices to cxgb4 driver changes 
and do it as seperate patch later.
I have included the same in cover letter about these checkpatch warnings.

If you suggest fixing this, i will include the changes to my next series.

Thanks!

> 
> ...
> 
> -- 
> pw-bot: changes-requested
