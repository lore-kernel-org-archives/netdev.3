Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C09241B8F3
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 22:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069676; cv=none; b=JxrpWwfpt2vUsmM3QMnnkLTW3Ihf+MKo942daEggf/xjMo0J8u/xIX3++5Rk/cnXALEmxV1+cxXrzGd5T62OBBcX1Ny+XDcvMT2lWN5xFXrAFdnNwXSa0b/cJOGpBg8j1FhFjfQpXGvWXT+XKDUVCPyyNAmmYemyVGuqkFDKpeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069676; c=relaxed/simple;
	bh=uF88BBgFHPTOL8+5BQhXJVIaLYZ6TiN+MwZ5vtbduuc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tduq7DW5R1GjOUABJobwLjhgkwaPdAtj0T9sRF4Ab6/XCJzsCnRnvEZG/YdhX2ndqU9Acr+j/WtXJPaeNRR+napA2Ug1+MHe33ybFtzU1iXjQ/gwAoFgs6mwIZlhPHJuuCuKxZ70UJ10Ufao8C+L+S/RfgPW671OSDfo1+KC15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDB/RDu1; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDB/RDu1"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c860544c077so3493418a12.3
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 15:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784069674; x=1784674474; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=akt6QgIGACeYYOmSTe2Ca3+zVAkuk0kMPhYLokTQESY=;
        b=jDB/RDu1+/yYKuQoBDRTLblHvugkRLjDlHgyDIOhssv/kNvIjZ8Gou57ILFL/zz9Pb
         4M2HfiATIJmAVkglhs2iofnPBQOvv1gdZBZvEZN/J7tRiF3nWyPf2QjGQ7GWnReN2v4D
         EmTVOKhkNruMIegcPabLvRTVJQke+7ANeFNVAFtKldqmtovMHBH+MSa2RYJm5cFK2/tV
         6ptYE7xXjnpaenDME+n1eHI/GZ618X/XZd02L7fJ6CYa6+3YV9gO4My49CcEfuYSzfBU
         8GzXh68Xmh4SaUmp10hTy0+0syo3OySNFRTrqDg91YMTuzEsxHxivv3lw3ctn8NU74/h
         YWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069674; x=1784674474;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=akt6QgIGACeYYOmSTe2Ca3+zVAkuk0kMPhYLokTQESY=;
        b=QuE55kKQ9FQZrvdEjWmw989cRjwVBCclv9iZ6TirofJ5cCpf8lexTAmlAUXZCn4Lha
         ElYeAff9D5y2nVK82iZm5jLw8E9Pz6V9yZ/m+iFfltyq4F/PQ9P54lvzUHj/+XmRW7xC
         sYDUDztAqFaNQWJdKZoAcfuVHIjAUDn/JKx9dZr4FR3IyBiyr5VDSZh2fAbXzGUpxj/Y
         6sOkLHCtopN9xyyrf5vCclnce/XM9fNKhjfxpcp8bJAGihoHcwElp2qYLNDOK0AhZHIq
         fKjDCF7VsXimIhtuelb0AirH357fCuX6MxC2uUafsX+mYtC4ERzmPcB8oF6jF2KlTfyZ
         8gZA==
X-Forwarded-Encrypted: i=1; AHgh+RoUWxmD7TyVyfjNQ+k1+Q0uitkYar+Upc5q60qjkiW1ULWUmXaBNcsXgUakIPce9P5TntBU93c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWZz3SwR7ARXHQeZS9l2mbfeFwJB7apXV82bQrOeRRnG+SXNi4
	KHtEcuRlH5zHVSQBaar5kir4f5qUEi6vmTx/bU9sdc1h61o7M40cPBQEbAIrF6wXCcJ1YFmjcGl
	a5NekHh1/hKc2Eg==
X-Received: from dlbph10.prod.google.com ([2002:a05:7022:370a:b0:13b:9d10:4fe5])
 (user=zhuyifei job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7286:b0:3bd:203b:b587 with SMTP id adf61e73a8af0-3c1107757femr17791649637.40.1784069674363;
 Tue, 14 Jul 2026 15:54:34 -0700 (PDT)
Date: Tue, 14 Jul 2026 22:54:17 +0000
In-Reply-To: <20260708151327.1091570-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708151327.1091570-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714225418.264994-1-zhuyifei@google.com>
Subject: Re: [PATCH iwl-next] idpf: add flow-based XDP fallback for FWs
 without Tx FIFO support
From: YiFei Zhu <zhuyifei@google.com>
To: aleksander.lobakin@intel.com
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, intel-wired-lan@lists.osuosl.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	nxne.cnse.osdt.itp.upstreaming@intel.com, pabeni@redhat.com, 
	przemyslaw.kitszel@intel.com, YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"

> From the first days of XDP implementation in idpf, it relied and
> worked solely on top of the queue-based scheduling Tx mode, which
> basically means simple FIFO. However, turned out not every firmware
> supports this mode and XDP doesn't work there at all.
> 
> Since the flow-based scheduling Tx mode is mandatory and supported
> by every FW, introduce a simple fallback guarded by a static key
> to not hurt the more performant mode. The FB mode generates a
> completion for each Tx descriptor and never guarantees that there
> won't be any out-of-order completions. Serialize that using a
> bitmap of completed descriptors and report contiguous blocks of
> free bits to match XDP and XSk expectations and avoid further
> code complication.
> 
> The usage of a bitmap on hotpath might sound scary, but this
> fallback is able to reach around 70% of the QB mode's performance,
> which is comparable to what ice gives us. The main bottlenecks are
> unlikely()s and one completion per each descriptor, while in the QB
> mode we have one completion per batch (which might contain 64 or
> even 128 frames), plus the size of the completion descriptor is
> 8 bytes in this mode (4 bytes in the QB mode), which means a lot
> of additional PCI traffic.
> 
> bloat-o-meter shows .text increase in about 2 Kb without adding new
> functions or uninlining any of the existing ones. I played a bunch
> with inlining and uninlining certain pieces or the whole fallback,
> but the compiler collapses and optimizes libeth templates so hardly
> so that each additional external call only makes things worse.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Tested-by: YiFei Zhu <zhuyifei@google.com>
