Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792920268;
	b=XyQQmpkL82uT5dwQMCEbAFbNyHW1hdlAQtnKYGgP0utpCWWw+I5H04xISzGGJ4hmmeOk
	 MClLa8UOpgrLOGWkuPKEj6/YMyLytS8kmyxM1Lueud+vnqkh4tpTqJ2Phu0FY+tSVMl90
	 18sQB4uZw3mKYnDiQAIo28Mc5ygxCOV/FmZsPjF3t/YwTP1feVUmr1NOOOaZTaD2ZZ00S
	 TR1UULgdetqWtXoudbdjQ8Me61SM7YH+5RWiHlVmW3SCitwR9yvTi2EiOHqf808tjqDSp
	 +lTKnbAMC1CYHCktRE96x7vohsU875XVvWsWLlgcv0ZA0xLKUCeKF4psGHxxQEH7SLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792920268;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=t4nEnFfV0UT3yZ846FnXeJLSbq0o0Mt47F1zaTSriuw=;
	b=iiLRdvCoymB+i2X5t9BG2oQ9VRnRbIDgv0TUv1HRzABYER90cYjHrK7vQMVrA5Xq4WvE
	 cW7wtai/p5c/lV/zx34NaQtBycKS+XwZGvlE2aWBj+MODEGI3Otj+2dpAsTxSCmYbVC4u
	 jI8nZMkH+5l+0obvZfSBdJ7Ml754p7o+4qPDcaPuvK5suaEoaF+8qqRTWGD3OsGCL4E/d
	 CHKjw1E+vbvrmR7+QqH0AtwKEZchoMMrrEVHuASS44H90VTt8ANml22DQ3iJO2UppYXSS
	 krbcC2XJO1sEeI5QtppoMwyiv3LLbwywbwmGyvXIBjp7uCG2FQ7iRIcIcfsBMgRYRyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jpIQe416;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12441606A31B;
	Sun, 25 Oct 2026 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jpIQe416
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3422B1F01825;
	Sun, 25 Oct 2026 09:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792920267;
	bh=t4nEnFfV0UT3yZ846FnXeJLSbq0o0Mt47F1zaTSriuw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jpIQe416GfTxRMaN2bHWHeEYJLD4jfYsG9YeRaWJNDLM/qNrMxZS2gvGramOeQiG5
	 AduUQ3/hbzTnKVrh8+9BkHVA4mp1aO3JefRK+Sv/6voC12ClTpg/99BmNU8KrgFYlA
	 OqTyJTo3PffV0tHD8K4lLdwc/uye4h0q6ih+ieMYGihE+x4Q76url9b7/KHoJv+MFV
	 lfdKZXNc/tJMgMay7e3OTG65jV02vNuYFIUgNnpg1zqcNbzS4E95CcL2DGFpDpHgpT
	 yNlgKWvpJpl8+1MNQbdSDlFmzFFY7nVQnLMn7FHd8SQbGe6N8Osy+/d4aVJ/tP+uja
	 STOrEaD9kDcPg==
Subject: Re: [PATCH v32 net-next 6/8] net/nebula-matrix: dispatch: implement
 channel RPC framework and serialize hardware ops
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 andrew+netdev@lunn.ch, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 09:24:26 +0000
Message-ID: <179292026679.3134.13737137805222935440@kernel.org>
In-Reply-To: <20261021062113.2158-7-illusion.wang@nebula-matrix.com>
References: <20261021062113.2158-7-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Baseline decision: false (resolved later in the series, retained
  only because requires_validation=true).

--

net/nebula-matrix: dispatch: implement channel RPC framework and serialize hardware ops

This patch adds mailbox RPC requests and responders for cfg_msix_map,
destroy_msix_map, set_mailbox_irq, get_vsi_id and get_eth_id. Each op
resolves to a local resource call when has_ctrl is set, or to a channel
RPC to the management PF when has_net is set. The five responders are
registered with the channel layer from nbl_disp_setup_msg().

> nbl_disp_remove() documents why the five responders, which are owned by
> the channel layer, need no explicit unregistration.

[Severity: Low]
Is this paragraph accurate for this patch? The patch does not change
nbl_disp_remove() in nbl_dispatch.c, and at this commit it still reads:

void nbl_disp_remove(struct nbl_adapter *adapter)
{
	/* Dispatch structures are allocated via devm */
}

There is nothing there about the responders that nbl_disp_setup_msg()
registers.

The kernel-doc for struct nbl_dispatch_ops in nbl_def_dispatch.h also sends
readers to nbl_disp_remove() for that explanation:

 * structures are devm-allocated in nbl_disp_init(), and nbl_disp_remove()
 * only documents why no explicit teardown is needed.

The full comment arrives in the next patch in the series, "net/nebula-matrix:
add common/ctrl dev init/remove operation". It explains the teardown order
cancel_work_sync -> nbl_chan_teardown_queue -> nbl_chan_remove_common ->
nbl_chan_remove_msg_handler.

Could this paragraph be dropped from this commit message, or the comment
moved into this patch, so each commit matches its own message?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021062113.2158-1-illusion.wang%40nebula-matrix.com
