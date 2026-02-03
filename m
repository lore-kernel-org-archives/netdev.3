Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94BD3A0E8A
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126789; cv=none; b=Haec5m//0dw87V36k6hf2CZWhDneHsrTtOLZbtHSrGmW4pWbCba76xYwfIxD4ITe7VKBf29Tf1t6x+DxoZ62WH3EQ+W44fFQlZRaIvVFZdKW3pay7Gstm7mubTSIGdPFdVnMtNre89dEbJw8IarLSVU60Hh4KDrI85C1RTc2gXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126789; c=relaxed/simple;
	bh=SGp+Vmr47lniXyGxN6f8J5XR97iufx9AVuYZFTaSP4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQUh5R2dRTQpUN6g2Of/J2FFfVGJn6LOM+K9lNEVibcnat1j219HDYGMdK2pZX2PVKYlAHRm7aTFaN7l1bcdMlqQn0cIP87iiJ5FQYMNMjjAgV3iNQVRf2gzfU38Z+QG9OTMQXrfvxcYXXg86h2zjed/WwJvXckUJYei/ZBzeq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=T91IorZT; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="T91IorZT"
Received: from ms-a2 (182.51.30.125.dy.iij4u.or.jp [125.30.51.182])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 613Dr2n1008421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 3 Feb 2026 22:53:04 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=WumWOs7FJGqx0XgG1T98oPyzhxUL0T3RGf6i4vVvYrQ=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1770126785; v=1;
        b=T91IorZTIuJwtY8aCL8+p0dk3mQZ0vHFUuVjCG+igmGKyzGCIzzmmlABWZYdBEzb
         BpB/HSwLm/gS7IF9JAlIVe0OvRtrVReWNpKXX2YZWjtA7IMoMgElZYFIaUi1w43C
         qMr0wex1t6ZJmhyaU2NoDl8h5g36e6mE1X8TxHNKYC5GhR7Yl4+AJcFUa9HxIg8o
         kmLgCO2Rk/5c9O/rRNAfKGcBvX5uCfoh0zaF3KdoNkRMKum4clbI49qzzpeHpIHR
         93BjvdStkHqVETso4rdVK9naBEEy04vcFzXESp6gHCq5d6EWjVmsj2VDgOtcF46f
         2oAQRWCa2Kcq8QbGlMTSJw==
From: Kohei Enju <kohei@enjuk.jp>
To: takkozu@amazon.com
Cc: aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch,
        anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
        enjuk@amazon.com, horms@kernel.org, intel-wired-lan@lists.osuosl.org,
        kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
        piotr.kwapulinski@intel.com, pmenzel@molgen.mpg.de,
        przemyslaw.kitszel@intel.com, Kohei Enju <kohei@enjuk.jp>
Subject: Re: [PATCH iwl-next v6 3/3] igb: allow configuring RSS key via ethtool set_rxfh
Date: Tue,  3 Feb 2026 13:52:49 +0000
Message-ID: <20260203135300.2849-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260203125417.37285-8-takkozu@amazon.com>
References: <20260203125417.37285-8-takkozu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 3 Feb 2026 21:54:13 +0900, Takashi Kozu wrote:

> Change igb_set_rxfh() to accept and save a userspace-provided
> RSS key. When a key is provided, store it in the adapter and write the
> E1000 registers accordingly.
> 
> This can be tested using `ethtool -X <dev> hkey <key>`.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Takashi Kozu <takkozu@amazon.com>

Tested-by: Kohei Enju <kohei@enjuk.jp>

The details of testing: 
https://lore.kernel.org/intel-wired-lan/20260128072908.50245-1-kohei@enjuk.jp/
