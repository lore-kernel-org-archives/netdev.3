Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FC34E1C91
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554178; cv=none; b=iaGr3X/6fIHjDMRJvCmmDMsMMvdJMw7iSPgOU1auSAIlnPyUHufabdQqqbtzme6uzIp98ATTaHOcT5bXgejgsWv8wGhWiFtdny1BqaPnWR10fLyj2pmPotVyx6qOYhdiDuSrpafGy1VW978U1aNNAiKPBK7K67GmVLtW6nCXKfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554178; c=relaxed/simple;
	bh=+FtCdMNUp9VTy6n93dMArq4VcPpWsspla/GY0Y5Aawc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZjrWl7YBPd+SKqn9fUz7VhA6WklYQUkWC3xzm/UqdkR10et22HFtX2l8LSyNZ7cJdF2lLFBXyd0d+neOhzHLRUOo5sq36AlSXL+Lq6AAQmQerASzpEBT/uJnXc0GkCG3ae6daCs3zYl66+vP9InqIV7J1byRntH5+XrJXXiQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmZaCFHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmZaCFHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71311F000FF;
	Fri,  9 Oct 2026 13:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791554177;
	bh=vMOMbF1LDAwDtzRK6zRn5c53GqCY5+q03iX3suO/+JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hmZaCFHUwY9RBLTy0kSclDyn7PXcvEeYr3Dk7VyXPnSelxlohqt17MmsTicPQUKQ/
	 3pJ4eYfi/CsKoVINlS/pYDqi20j3UEauHVqcrS+0pWIsmnv1Dtn5MgA7jhZ+FXnR3G
	 ROrkA4kxmQzeGSvbjFlfcLbzQbxrF8F1g0mJGjM6diCWOaj1dP8ZEi4JrAklRy8iR6
	 isJgtF+pakIWknKVmj09ZBqiA4MO+yICf7zWairC2GFhNAL1KkfNwq4ZW1hYJkrKQf
	 FgxDijjlp+3SuWEEjtVwLxgfitTDfPOtrMjNfeODmDh7N/N/ffoDKxUfdpzeLTk7L1
	 9tG5+46e/W3ZA==
Date: Fri, 9 Oct 2026 14:56:13 +0100
From: Simon Horman <horms@kernel.org>
To: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next v3 02/12] cxgb4: rework the interrupt handling
 framework
Message-ID: <20261009135613.GC83879@horms.kernel.org>
References: <20261005224830.377752-1-bharat@chelsio.com>
 <20261005224830.377752-3-bharat@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005224830.377752-3-bharat@chelsio.com>

On Mon, Oct 05, 2026 at 06:48:20PM -0400, Potnuri Bharat Teja wrote:
> The slow interrupt path used a per module handler that walked a table
> of (mask, message) pairs with t4_handle_intr_status() and printed a
> message for every bit it found set.  Each module handler open coded
> the read, report and clear sequence, and there was no way to express
> that a cause bit should be handled by inspecting a sub-register, or
> that a bit is only fatal when it is also enabled.
> 
> Replace it with a data driven framework:
> 
>   struct intr_info describes one cause register: its name, the cause
>   and enable register offsets, the mask of fatal bits, a table of
>   struct intr_details for decoding individual bits, and an optional
>   table of struct intr_action entries naming a function to call for a
>   given cause bit.
> 
>   t4_handle_intr() implements the common read, report, dispatch and
>   clear sequence once, so a module handler reduces to describing its
>   registers and any nested cause registers it owns.
> 
> The module interrupt handlers now return bool rather than void so a
> fatal condition propagates back to t4_slow_intr_handler() instead of
> being signalled out of band, and t4_slow_intr_handler() takes a
> verbose flag controlling whether individual cause bits are decoded
> and logged.
> 
> This changes the interrupt path for all supported adapters.  No
> functional change is intended for T4, T5 or T6 beyond the wording of
> the messages emitted.
> 
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>

Hi Potnuri,

Thanks for your patch.

x86_64 allmodconfig W=1 builds with clang 22.1.8 warn that:

  .../t4_hw.c:6959:3: warning: variable 'fatal' is uninitialized when used here [-Wuninitialized]
   6959 |                 fatal |= t4_handle_intr(adap, &ii, 0, verbose);
        |                 ^~~~~
  .../t4_hw.c:6945:12: note: initialize the variable 'fatal' to silence this warning
   6945 |         bool fatal;
        |                   ^
        |                    = 0
  1 warning generated.
  Warning: .../t4_hw.c:7956 function parameter 'adap' not described in 't4_slow_intr_handler'
  Warning: .../t4_hw.c:7956 Excess function parameter 'adapter' description in 't4_slow_intr_handler' (did you mean one of: 'adap')
  Warning: .../t4_hw.c:8209 function parameter 'adap' not described in 't4_intr_enable'
  Warning: .../t4_hw.c:8209 Excess function parameter 'adapter' description in 't4_intr_enable' (did you mean one of: 'adap')
  Warning: .../t4_hw.c:7956 function parameter 'adap' not described in 't4_slow_intr_handler'
  Warning: .../t4_hw.c:7956 Excess function parameter 'adapter' description in 't4_slow_intr_handler' (did you mean one of: 'adap')
  Warning: .../t4_hw.c:8209 function parameter 'adap' not described in 't4_intr_enable'
  Warning: .../t4_hw.c:8209 Excess function parameter 'adapter' description in 't4_intr_enable' (did you mean one of: 'adap')

Similarly building patch 3/12, 5/12, 10/12, and 11/12,
seem to add new warnings reported by gcc 16.2.1 or clang.

Please make sure your patch compiles for x86_64 allmodconfig W=1
with out new warnings emitted by either gcc or clang.


The following functions added in .c files use the inline keyword.

  static inline char intr_alert_char(u32 cause, u32 enable, u32 fatal)
  static inline u32 t7_tlstx_reg(u8 instance, u8 channel, u32 reg)
  static inline uint32_t

Please don't use inline like that, instead please let the compiler
choose to inline functions (or not).

inline functions in .h files are of course fine.


And checkpatch reports the following errors for patch 4/12.

  ERROR: missing sentinel in ID array
  #1734: FILE: drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.c:289:
  +static const struct pci_device_id cxgb4_pci_tbl[] = {
   #define CH_PCI_DEVICE_ID_FUNCTION CXGB4_UNIFIED_PF
   #define CH_PCI_DEVICE_ID_FUNCTION2 0x0

   #define CH_PCI_ID_TABLE_ENTRY(devid) \
	{ PCI_VDEVICE(CHELSIO, (devid)), CXGB4_UNIFIED_PF }

   #define CH_PCI_DEVICE_ID_TABLE_DEFINE_END \
	{ 0, } \
   }

  ERROR: Macros with complex values should be enclosed in parentheses
  #1741: FILE: drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.c:296:
  +#define CH_PCI_DEVICE_ID_TABLE_DEFINE_END \
  +	{ 0, } \
  +}

Please make sure the patchset does not add checkpatch errors.

...

-- 
pw-bot: changes-requested
