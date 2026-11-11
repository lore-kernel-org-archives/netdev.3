Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794422422;
	b=mY6XGZwtNlHrdVMFm9IoJRwEavgiCYnGVFa9S+VtV0N7yiZUuZLmMfYl2LPHpVbF2tQN
	 8a9FuEGsL6hixz9Otq9RNR4d2nsluxHY0MbpWAZYgnFyl9L81faQD/fg5Ofo/BHcHlH+d
	 W/N9uaRYZ0KPfnVcQbW1IrsCIo/Eq8duk8nOjPXwQNrdTv+GR83vlFZMsXX2RPQhY/h1w
	 W/bo5WZBuOgE1ZwCO7ln2Hw8lWCk1V5k2er7OumIvfYxLb/h4YZbu4v4bJ53tVEMvKI9+
	 vHGFUAJc3de7XBkVf8HmcvfPte6qsJ0krpBWvSTiSpFSbLEzMlSEjxQJLAUQKECD2Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422422;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SUBjRrDLwp3RYZTX5EgqdOR+qdneuin5m0Edj6U64w8=;
	b=hc+yhVoNd+Gu5/A0Paygmq0CSvTXkMsTacqDeOEvEsD1G5a/Frf34hMfKOjrX8OAxxjC
	 z3hUq0YryEQ1tIKQgvJd2J2F27mLCSeT7npGOUD00r4gyMeCf+H0+wR7sok+4NmlS6zsJ
	 VfXYZYCwkNIAZk83P18jmShNe2cuFA/i6RdqWPjPLokd4hkHwa7WqDukQ6V0s3h9ncBfK
	 OZ7kgC/gAf5LeyNTTJo7966z5hHBSRd3u7t7UQG7dHS72AsYvI+QKb01eEJNmo+ryABje
	 eH308R+u0J3JkBvRDkTpoyJeWUAMtqwmJ3wbpeWsIGaepQSfgb3rpE95DMMiJ0YR2Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lulACv/e";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CC3606A324
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lulACv/e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9BF1F00A05;
	Wed, 11 Nov 2026 18:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794422421;
	bh=SUBjRrDLwp3RYZTX5EgqdOR+qdneuin5m0Edj6U64w8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lulACv/eTx0gduW7ToBPfwj6VRy3qO+ZayR6q9TpiWPFtWhGCrW97vLq1hXSlJSoG
	 gYzTOyPMd83v0/GZLOLcRka4SthpYNU01sKUnLBCy11lolD8Gnr6E/DPLpTriYkhBP
	 4vVlvTbjMFpz0rgNjjmSJmi/mWCevgoKcOsCoIJpYoey7bcm5cxBgikiuDSZqy0iUx
	 XLXaRgUJQdHHfY1DhVhbDfG+kmU1zgOir3Bm7wV79m/RSdkjxO246CQ3gR14DglQR7
	 upPPbBUn/b2T4GtwmLvUWR0dzkKWo5Dfn9lKHuM5zy/JtCQJZ9j6npjUtwpWI2JluX
	 P9uc+EWSw6mhA==
Date: Wed, 11 Nov 2026 10:40:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 kameroncarr@linux.microsoft.com, ernis@linux.microsoft.com
Subject: Re: [PATCH net-next v2 4/5] hv_netvsc: move a new VF to netvsc's
 netns from a work item
Message-ID: <20261111104020.2ba90f97@kernel.org>
In-Reply-To: <179439413220.2199510.12624366739640158561@kernel.org>
References: <20261109194843.1353592-5-kuba@kernel.org>
	<179439413220.2199510.12624366739640158561@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 10:48:52 +0000 netdev-bot+sashiko@kernel.org wrote:
> > +	/* pick up whatever netvsc_suspend() stopped vfns_work from doing */
> > +	schedule_delayed_work(&net_device_ctx->vfns_work, 0);
> > +  
> 
> [Severity: Medium]
> Can this run the VF move or takeover before the VF's own driver has
> resumed?

The resume handling is a disaster, I can drop this patch completely,
if preferred, it's not really required for the XDP rework.
