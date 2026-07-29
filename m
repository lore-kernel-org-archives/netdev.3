Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4235622AE65;
	Wed, 29 Jul 2026 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290952; cv=none; b=K8HBQcfaqTHmTl0I2RFLrb5SK+Hl2aPZd0v8EBAMAk/uA7NGqAhZGlPOSMFtdOah1oPJK7wTllTJ+yWdAWP0KnGghf3524P/af3OperoyW6NIy5upHIS+i8ZGCWJgwFp/kPiWotAUyiXoopVm6cNIkH6qLFeIvHFxuR6yFn4jYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290952; c=relaxed/simple;
	bh=Die6SPGiSjT+/C2ef2pg0tH6LLmBYLVI4gdSu/kSH60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyhrgjnf77koIItaPNN4Y6E7YASb19qS+U2BQoMf+4zmOoaO9oZdX6VMK40it1V5TXpe5BeHqIAWoX3iE2S655GqnGTt2HXvwGR4ZhHysogVjwJtKSYWaxYprDsWTtPw9IV2h5IA6wl71dF74VEaqjNwpAN0jJMjEsQms0XMXoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9q3TSsl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9q3TSsl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63091F000E9;
	Wed, 29 Jul 2026 02:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785290951;
	bh=6HtKcpAxcILsIkL7IPXsJvMgiPiXiucSTfELZg++EJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q9q3TSsloj5newJIxgLO1WuGGhBF7VVVHwKSMN8w/CCI6KTtRwWBGE2YMZVINVSz8
	 11Q5S/2sv5whIBLj2byOGDadyuV/eKlx2pE8BPm4NUWFc+oYI7TlJe3+AoBvf8+Cb+
	 r4Z1ly/MdSNfzW6fEAA1rbJ7H7MjSv6X+MxV8YUy9jQ7TOkFoxRjUncPUCCSfZf6EA
	 oQzqwySZ8tOIhWsdj7AbYIsBYWm57Ewa91t26c3C6jYB/k/XMErjTq67oAdvb180fr
	 4ErRpFJrI1J1NPsumkWyICTcFQ8fQvcTj8P99CucfCSDChQvuZSGLeyG8ml3Go7I3Q
	 xIMGykA4HePew==
From: Jakub Kicinski <kuba@kernel.org>
To: vikas.gupta@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com
Subject: Re: [PATCH net-next 1/4] bnge: add steps in bnge_shutdown()
Date: Tue, 28 Jul 2026 19:09:09 -0700
Message-ID: <20260729020909.3657119-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724142954.3101980-2-vikas.gupta@broadcom.com>
References: <20260724142954.3101980-2-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
--- Patch [1]: [PATCH net-next 1/4] bnge: add steps in bnge_shutdown() ---
commit 92ff52be8a6aa712b5331ce7118ada003154f2ee
Author: Vikas Gupta <vikas.gupta@broadcom.com>

bnge: add steps in bnge_shutdown()

This commit updates the shutdown callback to mirror the close sequence 
so the device is brought down cleanly during system shutdown.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
> index 68b74eb2c3a29..9846d29b4fe3c 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
[ ... ]
> @@ -406,12 +408,34 @@ static void bnge_remove_one(struct pci_dev *pdev)
>  
>  static void bnge_shutdown(struct pci_dev *pdev)
>  {
[ ... ]
> +	if (bnge_hwrm_func_drv_unrgtr(bd)) {
> +		pcie_flr(pdev);
> +		goto shutdown_exit;
> +	}
> +	bnge_free_irqs(bd);

[Severity: Medium]
Will unconditionally freeing IRQs here trigger a kernel warning if the
RDMA auxiliary driver is currently bound?

When bnge_shutdown() calls bnge_free_irqs() without first tearing down
or unregistering the RDMA auxiliary device, the auxiliary driver may
still have active IRQ actions. This usually causes a WARN_ON for
irq_has_action() inside msi_domain_free_irqs() during system shutdown
or reboot.

Could the auxiliary device be cleanly shut down or removed before
freeing the interrupts?

>  	pci_disable_device(pdev);
>  
>  	if (system_state == SYSTEM_POWER_OFF) {
[ ... ]
