Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C700F3D9DA6
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 03:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700443; cv=none; b=QbvhpOBvrI25Ec6B746G+POCOpAwkIcS7v12QkczKTFq89LpnMXKi3GATFUpM+i9iZqYmOMkHyMX3eUISs7fTv5P4K+qdzd8uUeEbZTT3ffLYCTorqigNC2fvBQ/942YcyGM8ZX31wwb2EZ/KCdsROAu001A4mvoeL7RzC3XhdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700443; c=relaxed/simple;
	bh=GHQTKoIXhNNoU3fdktsqcQzosZ5PZu724WYv5roiu7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8wDwXmNrXo5cDab53cNeOmV5GDzt1Xqw3ktiLoouvk11vlDx62sjNPUzWHChBYdnR4S+T11jMICpXPMqwimxJMs+Gvq9UvJAVoEdwselIC3vKaryOTjlbckOVRlwEyV7NSk8yZWPi449c6KVRKIRBAYSTsy6NHPBFdesiH19n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tmv5QcA2; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tmv5QcA2"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469a33c9cso434690b3a.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789700438; x=1790305238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GHQTKoIXhNNoU3fdktsqcQzosZ5PZu724WYv5roiu7c=;
        b=Tmv5QcA2fRRqTwkOvvS1wR+3kQN3Lcsmtfhg+hFrepPp5YdM5Xi6lLwRgwaM/TOqnJ
         iy9yjHLyWL3oZ66Ac5hXMnG/URCAM++YDBs9rXEE3llrGArEiMbI9zc2DFUJa0+38ixZ
         X5hVyT92SlKigDO9qo5STIo49GjepcdDE0Njtss5Vjs4tRPqHO7amAnUhIfLrEjwQ14w
         3qjkJaRCMIAzjuwN54pvQBEBSmvmFz/C/BY4bW/jqXSnl8Drq+vl6oX2PWKdGT07vnA8
         o4bcLuxxjmFtxe27xc4po2e6accp7AjsI56jJgx4ndagYr+ixmB1h96Bl8jh1SYeiQy8
         n7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789700438; x=1790305238;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GHQTKoIXhNNoU3fdktsqcQzosZ5PZu724WYv5roiu7c=;
        b=H4Tn0LAnGqfWaXFLqPw7HcEo6sINkjJuFDhY84tiUfQvuuF04rp7XNaCGx0MsXQp7P
         //1RUBqIECAoAyVoUmhDbKouCu8wPFMkH5doGNjZW9A2iRCq+rpFNfjU6cPgTFxe0Imm
         atAp+f3AbgOtcVa2VHyjloAmjwrfkPPtFS/7Udyd+XlthLRqLfz8l4QlCzfcxaqeEB/Z
         7/0ZpVGbpoBqnX0MBAqpTTy884rFCEHgnr4gNbWaqM5cbkz3ccSbDLuNTF+dx6xnvAi7
         D9GCUGhgePBj6n0qJxoznSQvSp6S8Ntur5XXZNBMTesjM2a38+EdAMBozB/PKpNvyCdQ
         utYw==
X-Forwarded-Encrypted: i=1; AKwUvBxzXdyarPIxPrGmcTHv4BoiWk8U+hgaslWiHYNwE1f+5g0IyVu3Ouu3/NWhVEGagTUFK2yKRjs=@vger.kernel.org
X-Gm-Message-State: AFuF++n6p1uElul8byFVYSGAGSI0OReEiJGi2Vho7jSzpIvQk+O2pKHM
	fIQEMAjvcVd/dfTsoX2bcU8PevY0Gbh5eG41f7onQqQlGjLwNrOo2Fa9UfdnKQCI
X-Gm-Gg: AYBFou1RfF42cFInWM+C4j1sa3WdVlz35wnr1mJChElecZoBTE8iyead/dwKmNh5ac4
	2QePU/cAyh4YwoM4WDOJWbsdKOxBxg6LetZpnnKXfooM/2u2WoNoc4IMAmg7YXZd8ul3J3fbEO0
	b0N8KxLLaaTcOgLFXiVmKJfqg4cK/dmZ7VPZhlWmduz5Ylde4OwrJF5tEmBnZmZRE1rvGChJHU1
	89VkmFF7umBwFAj1iMQ93ZpfNCjE8h3ixXzQ0lykW23ZDBwsgEW2t7la7ubkggAoYXmbg3lCxuP
	uxzM5GqdrLyWiyXftUeS0jUdsxe3tNW9W38RCpztTermD7/1aHuv+srt9DvU8DKCWDTBoT+xiEV
	Am75Pa8go/TBD2xure569x47zrQQ75p9tl+ZxhvZ5/bJ/BM7UaSpCKTQ6hkCyp84fMT/ZMelzsY
	e00XPDdRpewGT1TTqyQptpfuLWhl24jmK/k5mnyLRs+ESVjQVc10UaLZ0rXp4BVxFC
X-Received: by 2002:a05:6a20:4386:b0:3da:f969:b077 with SMTP id adf61e73a8af0-3dd8c425bdbmr2587035637.11.1789700437925;
        Thu, 17 Sep 2026 20:00:37 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc5c50cb2e6sm120905a12.24.2026.09.17.20.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 20:00:37 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>,
	Justin Iurman <justin.iurman@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stefano.salsano@uniroma2.it
Subject: Re: [PATCH net] seg6: keep room for the mac header when growing the headroom
Date: Fri, 18 Sep 2026 12:00:26 +0900
Message-ID: <20260918120026.1205447-1-yuya.kusakabe@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917182826.452d987261004173916e9722@uniroma2.it>
References: <20260917-seg6-maclen-headroom-v1-1-02ccec50f096@gmail.com> <fd0ffc06-f1c5-42d6-ae16-b592208c6d69@gmail.com> <20260917182826.452d987261004173916e9722@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Thu, 17 Sep 2026 18:28:26 +0200 Andrea Mayer <andrea.mayer@uniroma2.it> wrote:
> I would fix dst_dev_overhead() itself rather than patching every
> caller individually, that covers all callers at once and protects
> any future user of the helper.

Agreed, I will send a v3 with it and a Suggested-by.

v2 crossed with your mail and still patches the callers; please ignore
it.
