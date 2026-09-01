Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD9A372046
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788301259; cv=none; b=Qd7xGVwh2FgafZ+TWmq6Za96fBwH0rpTtg1MBEE9VJ/iqekFpeig+82Vq9fRfO1lWAiAKKrICSZsMB2qadlriFuahfJk1SfZIdQRo6adrvOsnDGg5r18ivLzPqSbHLNpxmEnXZtXAK6EFnGMfmiwnpo+dAIsSiAmzgotFiYlOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788301259; c=relaxed/simple;
	bh=myUGKsIhhdsQ7xKD8B4al672yI7o2nYXZo3hk+JfA8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtNkYrdeXLbeOhoI7ZvEH8ZMkuTQ7fpTP/s7OQJ4GuziaAIRHAGXWOq3upKQzgJhlYuwPtJBKqc70LQmmoHMNQwD/6kO1zwsNPIbNP11HuX8pPj+HzJoYV0cDbh+7bFjWQeht8a+YV5gutQG2HpAaNXFBmIJsqyXnB3VIG81noc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=mkr0p1sp; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="mkr0p1sp"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1e1ff659bso454452a12.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 15:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788301256; x=1788906056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ip2DLCZSajo2LxMMkPcc5eG92s9i0r/zxGOa6nq6Qi8=;
        b=mkr0p1spYU83aVYvfj9snqOceSYZc0DtBpxlFIe0VoqwNkonMaF546scF/WrExbWoO
         byKXg+zuJbpMOPBG0pt79s2VLPRtw6MzPUGYw2GjWGk7jXYtwnUlAAARr27QpvPeQlxv
         u+dxpXkNzQP3nekwweCUgpAXLTQVIdMp7HvC9KNIEgFFnnG6csbOm9WNAJ+J7/d/5IPp
         ouKGY2XDTJT+Kq4TlcR2PwiV3ubgWfEqjmGwXB2sLaj8e1HuJjkAS2nO0OS/IU3HE6Ag
         sUCXHikxnGw/3EK9S+j6739FennxF+bSd9pmZyDSO2gOSdRzjUp4W2aEwom59Qn8UNwz
         5D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788301256; x=1788906056;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ip2DLCZSajo2LxMMkPcc5eG92s9i0r/zxGOa6nq6Qi8=;
        b=q6pjDibaJe9HnsGkZhe0rte8IZKy3Vh7Uj+WRsEEyrlOmLoehwVaOBK2GhOH90lFif
         vH1mO9vfAGFGeA0ocA5TqurWymUdXJuSgoZLICxIzBf40fFHXwr6lgyTWpgqjpWNvyc/
         YAfbTY1uWYgAWmt6BQ4R5jLhInHOl9P+KSUm2gurmCc683C6i/ppXwjnAg+wak3NGwTk
         bExtGg4mBRZacjtYIfCwIU5rKry0/kJq9nuZo9/IhyXUhCbKsRQ+kW+HE70dNW/Gf3/D
         X9eACW7hCVUUD2++SLWUQI54HxBAD5s6M//tlAn7kHtP1eVeqTrWUuPumT1RzqFWhu6H
         vHPg==
X-Forwarded-Encrypted: i=1; AKwUvBzXVWdtpjMAqM4EbwyizIg98LLuQ789IvJhb+3MAn0u02FYD7tiBZSaomBbuxEHIBIY0SyPUEg=@vger.kernel.org
X-Gm-Message-State: AFuF++k7c8+TeGKPkDiqfI0CAY6PJyprJstnvI7Rg6cUVo8FuX6up1Lf
	q9VKuAtREKlpKxZpTRB1RQBusv7/zFGVdPPIw3BdOnmGgNvXI6o6pl8mrsV/E3DtxSE=
X-Gm-Gg: AYBFou2gSTj2XaxSw/3U7C/oHV4Ee39ZcalbjGdp0qu1UBAdUSMURS3iFi1XryVrwex
	wb+J8ktyPbKluDPsnNnCqs1Y2VtVOptQAOI1+m2pkGzWLH7I0uD7TGVepU5M+TzHqjNbfdmYqeF
	qNPLkLwIJZztQBQi95eHqXq1kYI26oXMu7i9h1E2i6X5y7AoS1a1Hct/mpruaDj7qZrz1ZpjC/5
	Qk+Kd5rHoh9JqxVwT+8qkp5fUwSlNpw3IwIu3I/A+ewhws7oiX6o175xkEiD9eC2FGrbXRrQXxE
	LE3zLpUc2q/fe5nAs8out2jVSSA4ZUgzSwTKn/h403eMxSteAEOb6/MdNl7JHCv1IsgkxK01TR5
	gvLq2vBdxV4xAPfa0EQzcL2nbYtXLkRi7e9l3PWPXIECd9svSfPu3cdtZL99DMrZe2CU0Tieu+f
	JsE6ipZaxhFcoRaiuqC7USjYdU75LPAyIxQ1NNLoEn
X-Received: by 2002:a17:90a:c106:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-39aedf1a98dmr250416a91.7.1788301256004;
        Tue, 01 Sep 2026 15:20:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae8ccc72fsm185214a91.2.2026.09.01.15.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:20:55 -0700 (PDT)
Date: Tue, 1 Sep 2026 15:20:54 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net 3/4] bnxt_en: Fix driver init in kdump kernel
Message-ID: <apdPxp9FHmucCRKq@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
References: <20260831024342.2161156-1-michael.chan@broadcom.com>
 <20260831024342.2161156-4-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831024342.2161156-4-michael.chan@broadcom.com>

On Sun, Aug 30, 2026 at 07:43:41PM -0700, Michael Chan wrote:
> The driver forces an FLR during kdump kernel initialization to reset
> the device.  If the NIC is behind a PCIe switch in synthetic (smart)
> mode, the switch may need to see that the BARs have been initialized
> before it will pass Mem read/write TLPs to the NIC.  Save the PCI
> state before FLR and restore the state after FLR.  The BARs have to
> be cleared to ensure that they get re-initialized.
> 
> Fixes: 8743db4a9acf ("bnxt_en: Issue PCIe FLR in kdump kernel to cleanup pending DMAs.")
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index a76674fd0d6b..c3d561ac53dc 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -17091,7 +17091,10 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	 */
>  	if (is_kdump_kernel()) {
>  		pci_clear_master(pdev);
> +		pci_save_state(pdev);
>  		pcie_flr(pdev);

idk if you gotta check the return value of pcie_flr. seems like most drivers
don't except ice :(

> +		bnxt_clear_bars(pdev);
> +		pci_restore_state(pdev);
>  	}
>  
>  	max_irqs = bnxt_get_max_irq(pdev);

the above aside:

Reviewed-by: Joe Damato <joe@dama.to>
