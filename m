Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7279F10F1;
	Thu, 30 Jul 2026 00:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785369954; cv=none; b=JcNDRnNSofM0vR7SMSmunsDGGBcIPbI/bb7VP1rWu4gzprx6BL2ZlS6JvCoSO/uTKPtdTAIV96ZghNk4T/XEnfgyJnZQjthSIp82KbWH1dp+xQsg23Rhx+O32QGRIB5nSSA6aRPVp1UHGCTjvoXVB9x3VfMgvQNFSBbf0xqFcHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785369954; c=relaxed/simple;
	bh=yKOZMko+07+wq1BTQ59XXIY4D+yWdiPmxLMivwhLCAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6c2N6oe98Ln5cAWzebOBM9Y9fMFzl0tP6lrBe+7P1thivXilDjBGGnLX0TM3LPnFz0TDKPG97dctabbU46boPQ0pRJpcfNM0EQfTQ0zoeGlDLYTlgXRw/D32Sp2riGpS9a5jmOpZk2b1b9Pr1H0SJvXMqymNHvw9HElMCcdeTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmXJ3GdB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmXJ3GdB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18371F000E9;
	Thu, 30 Jul 2026 00:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785369953;
	bh=/59SzgdMorTLLxci0D6qY1ZSLIVOz56POr7mx+5/ykg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XmXJ3GdB2OESjnRigvbE6X7qehOiLGPateyu7d1Rx1pFkOOQj9E2rKmBYK8PGYSOS
	 /xwaigSK3aHK3ly5Dm6iVI7eJh0RTp9bk4VLHzKrTUT4DOvHeHk7PWA7JstTIHhYqj
	 UkOGOMkf0DsSxwxF973yK6dss6ypOlQb+/zpZ6ztQKfrVTRcAb0YdBTsuQm/U+/DpB
	 DGVG59kgoagBH5zwBw9MC9Lx799a47MdIfST7+sW0HYvYp6BXsvCKR1P8UEMihcqHr
	 kMsAoTDztdp5QDJ/C5AnEpYLSuhSaasF/T05BPwNQGUI3ZLEAEAJ2Qx4D8aZMcWecu
	 r64Sj/Ul2s2eA==
Date: Wed, 29 Jul 2026 17:05:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ayananta Paul <ayanantapaul@gmail.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: netlink: fix spelling in
 tcp_metrics.yaml
Message-ID: <20260729170552.3c320d1c@kernel.org>
In-Reply-To: <20260729034147.6970-1-ayanantapaul@gmail.com>
References: <20260729034147.6970-1-ayanantapaul@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 09:11:47 +0530 Ayananta Paul wrote:
> Correct the spelling of "reordering" which was incorrectly
> written as "reodering" on lines 113 and 115.

Unfortunately the uAPI define is also misspelled.
You will need to squash something like this into your patch:

diff --git a/include/uapi/linux/tcp_metrics.h b/include/uapi/linux/tcp_metrics.h
index 927c735a5b0e..74cfb9f7509c 100644
--- a/include/uapi/linux/tcp_metrics.h
+++ b/include/uapi/linux/tcp_metrics.h
@@ -35,7 +35,9 @@ enum {
        TCP_METRICS_A_METRICS_RTTVAR,
        TCP_METRICS_A_METRICS_SSTHRESH,
        TCP_METRICS_A_METRICS_CWND,
-       TCP_METRICS_A_METRICS_REODERING,
+       TCP_METRICS_A_METRICS_REORDERING,
+/* Original spelling had a typo, kept to avoid breaking uAPI */
+#define TCP_METRICS_A_METRICS_REODERING TCP_METRICS_A_METRICS_REORDERING
        TCP_METRICS_A_METRICS_RTT_US,
        TCP_METRICS_A_METRICS_RTTVAR_US,
