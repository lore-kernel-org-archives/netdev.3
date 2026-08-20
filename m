Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F4A38644F
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 03:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787197408; cv=none; b=OiYCgXUvCEXU/GAvjpubCva5j33Gxt7iY5vCGVX0blSh55pBliPP7BHBtSSmtcl9s2Q9HbFdwfnEnx7Mc3mUS7XWUcdyAyyGDma+N5vEzSjigeYHbxG0e9V5ZFHGJaJfDD23tejX2N+NiV2BKuSSi4YKA/49mnKreXXQs4EucNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787197408; c=relaxed/simple;
	bh=SUQUzfU153V9eAP2f4m6jjHNOdZgZOb4ZUg9by6Fk1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEPO7+fl/j0YC/imKNr7FLR/5Vk7AfbE1JEb52wCqCp9NfdHKs20D0+dwQ0YTdsdgN1Z7iQzS0eKubQNlY9l7p+7SpBFJLsTe+nECxwW7XtzBPaYiyB7gy1iZ5bAV1i9K98VhGYmMfgnBMkwji1KyU/MyidiGxPtX2oZXFaUdrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdddVRaB; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdddVRaB"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-836cda225c1so25496277b3.2
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 20:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787197406; x=1787802206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SUQUzfU153V9eAP2f4m6jjHNOdZgZOb4ZUg9by6Fk1I=;
        b=KdddVRaBHkdbDzv1+fCe2TxwckQxpPZkLNre5pUV9eVFReDiz3KBvlu3VUWYPGU2tf
         kGA36X1YMMutyJiLw9eI4bUcZyIqsD5dhn7+hbvVU2dpTi/Ixf3hCa9ysjLOTBWkweTz
         3SauJS1bQuqq0TcBKoDfEUsAL5FfwDLViwiYlGo61WzTUtvZP1o84EEqAtFDS/vCdK4C
         mXM6IErSz+55VBc5zA8Dx35W+20oB4iqyNgiWmuvSwNyA2iWyK+rJ6ivEfh7JPMfTomO
         L9nGtHkbKrmDjKa+JrSvIO8pzeiEzmZ9I6iIyS03u8rO6sgGKbQvo2uFBMn4hBPjGc4h
         mE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787197406; x=1787802206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SUQUzfU153V9eAP2f4m6jjHNOdZgZOb4ZUg9by6Fk1I=;
        b=hdM3xHH3V/kBWoY65AwNtBdmCeBbxvsl3JPqOR/qvZ9Kl52JwlBc9t74JRgIdsS7Zx
         hovuHjL6hr8wL+nyX/7mwpYkQf58sU2Zke7+fma/kUOBf+30f4TxckqPODOpTcSIobs3
         oH6UT3k9LrMh2NjwNJGDf2EHncFSrORR1AELR0piewMJzL7weofDanOQZbbiAMWLJ8c9
         37LdEEwDMEczLVEgUxD+rUOjv/NF3vs4+czJzzN8QEMu5yWgNnY6nfFdbBSl2PNcMkZA
         uVT86cePiy5YlJP6gCR8dv3BoDDvdq2NOXukRdP4ygyxJCrjZIzM9X4giFpuVa9J6bMp
         NEJw==
X-Forwarded-Encrypted: i=1; AHgh+RphqjPioAWDABNtdsesutUebPSpu1IyrWFFpGa8gVykif1rdGBjQbKHSRG164KIVJx76dh3xiM=@vger.kernel.org
X-Gm-Message-State: AFuF++klRkgpMrJ4q2Mcb5FKSAKBLGtnIn9ZF750+VYR7ckrx+/cF6BW
	9CJYR0r8eNbH+Xx5kMO9cPJFXC6B4/EsJ42YHSKinSn5iKB5GG4tXm72
X-Gm-Gg: AR+sD13qL6JjCVul3s77gnJSLF3LfJs0V5CtYesoSkYSfRIZHhFaNYs7rtvyqYWa/3g
	iqGIdeP1VQWMskt3T6staqVIUZ8uM8E3/eFCHbtknUDNkK7KSBsPDKw1bV5/5NdjlpvJwvqVPYB
	kaz990VZumHMmJJTO+3ZRFZ78y/YycD1Y16A3jN+jPbpSiPxBUxc6zWJIlgRjle6GbSomA7jHal
	iWuc2cg9ItbGYOiQSjcmXZ4HaqYk3p+7W8f8OF91jVX0cmheMJWpYKbNVFmblXpqK545jDr6gu9
	cEUjqqIA5VLIWMEHrPvqeGA0yPoj76TzRU0z1PDJE3L7mJHr2vYTfkyC6O6+lWaQKwLKUpvBnEm
	V3v6gNNIRKQ37j9recsMN6o6ILjgOKKMxJ1DSKtWYVzsrepHY+PH24iG/OCaPidMGgen6Zzh0OY
	RVOfHhwi/aR+F0/ItrKuCmkNvMmHDe1gW7e8oGZqc3dVAC5oPkpqqh0CXFFSL9mawQ/WU=
X-Received: by 2002:a05:690c:3387:b0:81e:89b2:91ae with SMTP id 00721157ae682-844e378f1a5mr42081877b3.21.1787197405974;
        Wed, 19 Aug 2026 20:43:25 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66ccafd03basm2037809d50.1.2026.08.19.20.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 20:43:25 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: xuanqiang.luo@linux.dev
Cc: AutonomousCodeSecurity@microsoft.com,
	blbllhy@gmail.com,
	coreteam@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	enrico.pozzobon@dissecto.com,
	fw@strlen.de,
	horms@kernel.org,
	kadlec@netfilter.org,
	kees@kernel.org,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	pabeni@redhat.com,
	pablo@netfilter.org,
	phil@nwl.cc,
	sbrivio@redhat.com,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu
Subject: Re: [PATCH net] netfilter: ipset: list:set: defer ip_set_put_byindex to RCU callback
Date: Wed, 19 Aug 2026 23:43:17 -0400
Message-ID: <20260820034317.79295-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <f3093e85-fd58-420b-b435-c39263c46e3c@linux.dev>
References: <f3093e85-fd58-420b-b435-c39263c46e3c@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xuanqiang,

Thanks for the review. You're right that this effectively restores the
stale-refcount window fixed by 439cd39ea136. I was aware of that
trade-off, but focused first on preventing the kernel BUG that can be
triggered by an unprivileged user. I agree that the final fix should
address both issues.

I'll rework the fix and send a v2.

Suggestions on the preferred approach are welcome.

Thanks,
Cen
