Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E9930C171
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505853; cv=none; b=muCByjJj/PCkuV7fuXFiSIbBlUyMUhDbfo5b+4oFUr4NCEFTVTq0oxk1pPEGb882uIjgGk3fFW517FyG6mOCkinexv94McIo6C1nfAM1h1ozEEy7Vx5khpeeynuIZ/lDE9eIlIgOFH1g2pQkylUZ+USw6UjXDmuw22MctYuzLF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505853; c=relaxed/simple;
	bh=f8yZkcVmz8X/zJe6i68UctVtU3pEPajP9RKDHAr2/cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQLw71P9RlsU60duo+hPUn2y+JEtW4rND3yrbXTXcjIIqv4OVezSEhrrHoVEJNcy3BXNi9yuJrNNSmA7l8PDV0pbjPt35TPqdIidcnE2vzDwPwdZ33bjuWX6dYsKOucgvC+KVAjyyqTdY2Iu1Is208AwEeihfP7BBoj/+VfEyws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEsPXWSO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEsPXWSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8932A1F000E9;
	Fri, 31 Jul 2026 13:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505852;
	bh=cZCns3eWuLSsfgbb38uCl9MT+3a/TtYnxE2Kh2kGIes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hEsPXWSO62Ii5srd6RJOu9pQ6CzvjX2FYvxD2hZV+g2UJYfHfH3Sh3APDIpxxdyvA
	 muv8i6Ny0OZZimwJ5iWjupr6kLKe9fVJEY35WcpEnbfh3mhh+db8NUUHC1GkFw4Zoo
	 UKy8no5XXTQBq/xxKd0iA5Wx3Bp1Cb7Hi2noHQ2GnxpKqh/neRX3y7waE3NRouyvl9
	 6s/2yqmlaLb5DB3apoXf2Ih988V/U86A6YzjGcRd1TC1rpWft/YVx73cAL3bMNEs1y
	 DH79FmpNrh9Spuvp6TkQi4SM9tHBKNt3MRUZ6hdCuyNr+iQ3KLbSgFRUw3V75I/9+B
	 +/4XKYtJX8DBg==
Date: Fri, 31 Jul 2026 14:50:46 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Joe Damato <joe@dama.to>, Larysa Zaremba <larysa.zaremba@intel.com>
Subject: Re: [PATCH net] net: ngbe: fix NULL pointer dereference in non-MSI-X
 interrupt enabling
Message-ID: <20260731135046.GI51943@horms.kernel.org>
References: <21947C51A754F86C+20260728093554.9324-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21947C51A754F86C+20260728093554.9324-1-jiawenwu@trustnetic.com>

On Tue, Jul 28, 2026 at 05:35:54PM +0800, Jiawen Wu wrote:
> In non-MSI-X mode (such as legacy INTx or single MSI), wx->msix_entry is
> not allocated or initialized. Calling NGBE_INTR_MISC(wx) dereferences
> wx->msix_entry->entry, leading to a NULL pointer dereference crash.
> 
> This issue was introduced by fixing the IRQ vector when the number of
> VFs is 7. Since macro NGBE_INTR_MISC is used in only one place and
> relies on MSI-X allocation, remove it.
> 
> Fix the issue by explicitly checking WX_FLAG_IRQ_VECTOR_SHARED to
> determine the correct vector index and using BIT() to convert it into
> the interrupt mask required by wx_intr_enable().
> 
> Fixes: 4174c0c331a2 ("net: ngbe: specify IRQ vector when the number of VFs is 7")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 4 +++-
>  drivers/net/ethernet/wangxun/ngbe/ngbe_type.h | 1 -
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index a16221995909..5d89fc84e8bc 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -180,8 +180,10 @@ static void ngbe_irq_enable(struct wx *wx, bool queues)
>  	/* mask interrupt */
>  	if (queues)
>  		wx_intr_enable(wx, NGBE_INTR_ALL);
> +	else if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags))
> +		wx_intr_enable(wx, BIT(0));

Hi Jiawen,

I am wondering if you could take a look over the following issue
which is included in the AI-generated review on sashiko.dev [1]

[1] https://sashiko.dev/#/patchset/21947C51A754F86C%2B20260728093554.9324-1-jiawenwu%40trustnetic.com

  Does this change introduce a desynchronization between the software state
  and the hardware configuration if SR-IOV enablement fails?

  If pci_enable_sriov() fails inside wx_pci_sriov_enable(), the error path
  clears the WX_FLAG_IRQ_VECTOR_SHARED flag via wx_sriov_clear_data():

  wx_pci_sriov_enable() {
      ...
      err = pci_enable_sriov(wx->pdev, num_vfs);
      if (err) {
          ...
          goto err_out;
      }
      ...
  err_out:
      wx_sriov_clear_data(wx);
      return err;
  }

  However, the hardware was already re-initialized with the MISC interrupt
  mapped to vector 0. Since the hardware configuration isn't reverted, won't
  subsequent shared interrupts cause the hardware to auto-mask vector 0, which
  will then never be unmasked here because the flag was cleared? This appears
  to result in a permanent masking of Queue 0 and MISC events.

>  	else
> -		wx_intr_enable(wx, NGBE_INTR_MISC(wx));
> +		wx_intr_enable(wx, BIT(wx->num_q_vectors));
>  }
>  
>  /**

...
