Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793305046;
	b=V+YUJ7Vs40HV0l5cHZ8FiqZ8/H2he0kSXA9U3dme3WOl5sMH93MJkkRmFZedLLbKf8ig
	 E8RqQg7xYJl/wCg50gpxBhuwtq+jJx60Tdc0wgWslTGpk43LhXs6/nxWbJQ4MvvI5FfDp
	 y1pYQURGYa+GKNvFGRInkUSGFVjL55cFaoYAlj8J1781XLv59sklPLnJp3BjDkh/3T49O
	 x7+z6BtV560X8moHhM9/TmQ25GFmBhPrD6TIk6wfi3RhQvbn2sIz+wMKatrqADode+M1m
	 /1Jh3n9U/ktwd3CDeIiPZ9oDNOr5WAmyjqQ42KDF55RdTEZau0L3aPpLxXrw2QC9IYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305046;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=l8TItYDD+miEgtskkO10ocU0yDgT44XQU9FLBrYEa6Y=;
	b=5qsoLHIrdtw9vIj5E8I7xW0ShwCPp0V+06UZ5GseY+u5zT6S5dKrzzUMDW+pbwPt9ax7
	 BKacTqvVDolAbI4hC+T1ZEbSfre8M2J1YuhOUZDh8MbuzLjCrbufVKS7ZzbSUXSRktjur
	 ISrSwnKp2i08lf1TC2YbeabMHGa2MC5YECcOm4sRFP6ThGrZUtHwcNVZdMqhy5sT9pB2s
	 2vEY3f4w8QTxSwkfgXBERPKduP1Mj1Xdf5tN7LlwFz6ht/b2ltX7o9QVE/G0E9HuruboL
	 qtuNSfm0SR19Jnj+FA3F5ApFK6Qg+HBTpvUrvDOo5nETfLSls4XgHgBE5CUIlLT/ZBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b="fk5tu8/J";
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E461C606A31A;
	Thu, 29 Oct 2026 20:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E461C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=fk5tu8/J
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B267C1A9B41;
	Thu, 29 Oct 2026 21:17:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793305042; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=l8TItYDD+miEgtskkO10ocU0yDgT44XQU9FLBrYEa6Y=;
	b=fk5tu8/J+ze8f8Z2MqtHHSJj5AubXhd0YV9uZYiWPGuvNbRH2md8K3+2fY+yfwYSPTgjtg
	yXQ9rGVDhVfjf+5jzJ644ksOPixdarUGNGFa0lBUF90aReEPPpfStMs33OhRdhXOhIQNRg
	utCCEylP1XLEeATFBfrO1REgnDrrBSHTbP/wv84bWwFjEiXq5kheRnyswqlEOEgEakk/4C
	eXhQJKr4UDSaWkHKJzRHBXha+QoMIr5G37Lb7fFYxVVfby/45XcLalYO50aniJSdbrJk8k
	/sA8mc5yDLzaXzgJ8MXQtcwDg7j13Y7q1Qs4WGpCN4T/UKbyrJjZrLaO1wFnCA==
Message-ID: <2928da24-a379-4d1e-baae-a5ae68acdf46@cjdns.fr>
Date: Thu, 29 Oct 2026 21:17:12 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 2/7] dt-bindings: net: dsa: mediatek,mt7530: add
 passthrough mode
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 chester.a.unal@arinc9.com, daniel@makrotopia.org, linux@armlinux.org.uk,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, naseefkm@gmail.com, b.larsson@gmx.com
References: <20261028011317.1557238-3-cjd@cjdns.fr>
 <179323935725.3134.9897775788252590471@kernel.org>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <179323935725.3134.9897775788252590471@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


On 29/10/2026 03:02, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
>
[...]
>   
> +  The MT7530 and MT7531 switches are capable of being operated in "passthrough"
> +  mode. In this mode, traffic is unconditionally passed between the CPU port
> +  and the DSA port which links to a second switch. To use passthrough mode, the
> +  upstream switch is configured with a DSA link to the downstream switch. In
> [Severity: Medium]
> Should this also say which DSA switch index each switch has to use?


This is correct, the active (non-passthrough) switch needs to be at 
index zero and I forgot to mention that. This was not fixed in v4 and 
I'll fix it whenever I send v5.


Thanks,

Caleb


pw-bot: cr



