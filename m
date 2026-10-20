Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483517;
	b=EqAMn9taAHoWsr8Dodim0VlDo5cJQ1vyrq/O6eF8qnvKNWVbEi6EVIL9jREWtuwCIGUN
	 KAwLmyreJEJd9ZlUmMhwD/XKqrj1XYl8CTFeTJ/iLZUrc+eCVUDWTtZfX5bgmFqddiqEH
	 +1vpqFM3lUuB9q+MBsdKINYp9z8leAX1ZrEnu/ZS5PFpdA+I1i+SJRYWnGBi9iMTXwLYi
	 z2LOdUTOGog60axu20mEQ6QKA6zvdXZaDx/rma7THOC5QFaVkt01WP5mV4bkO3ie271CO
	 9KojjB7cr4KIeJNRZqgaCWWnw8FYi8wA9kaseJ9y+VIp8KKPUMrCmBWhdQ5O8BgRkMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GPg92EprU8pd6RZNS84knIcONGEuxb3GDBAmGPh7pqc=;
	b=N67nzz+qhFHwU1onv/pJrxopOcRzUBJT8wMQ+w9tsMbmIsT+jMubobpkoPk3eWYCUJQi
	 YKtuxe/gIKYpXgGa/n+2o13c6AxFEGOP22hlBMRYZuHzCCLd6iMAkje+5ed2o+70Xaasd
	 0RMUrmMoFroYvFYgxjEfith7pWS2Os78orN9mRhQWZn7PyUPUz7bD2lY0N5lsHTKXBigD
	 CAU5mHneaMQ2DQxW8mQWPL+aLe+6QSK3m9gxQWaZ4WmHfJPu4vIX+Ichn4M5DbxdKtS76
	 J8hHsW3i17Uhx/JOjcM00GpRn70wYqkqDKoHO5dUaVPAREfGAlqG2rbdHkMJlNZWSfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qFKnXVQ1;
	arc=none smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4D0606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E4D0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qFKnXVQ1
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5be4fea434bso396482e87.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 01:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792483515; x=1793088315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GPg92EprU8pd6RZNS84knIcONGEuxb3GDBAmGPh7pqc=;
        b=qFKnXVQ10drmnI4HN5aRXpeaLOJkYq9Tab1fnPYppELjXVdHUSWEp+Dk1VNn5ENReb
         VwzP4JUSbupg4lvvQzvzg/36LSOMH7gG/w2Qar9ZI+ExP48nYy88fQzt3H5bv0FTd696
         eC3KQ4TvONuZEL5tLNguddcsvPPss71h1Q6yJHss3ENVEYtGTHxETQAgx1ETPlL4Purg
         LbiCMljC6M9zRqzNLy6pMf1A8jNVxhOh/w9t/OPaxi76TTDqxbPF0Ez44yM3cxkVvwe9
         Mj6KMw9v9eqeb4tv+TcsTCSqVk0BqCRhIEqNB981XV21I70KGJpxyRNW0dmmwq9//noK
         rvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792483515; x=1793088315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GPg92EprU8pd6RZNS84knIcONGEuxb3GDBAmGPh7pqc=;
        b=D0zi8JKMgKMEdLs0Cd9tPfsPm2WKXajzAbBDxB2edJ3DR+Q2uODsHE+JN90pWDk6Gl
         FC1IJBKuQW1KqgDpS6RRtiNKNxdusdMyTM78N1Q4MbD7m2IIQSPtK627sl6DoReHwLu7
         Lnb03HkvYoEHLVoD3HDT7d+28JrIxM+eKuwWaTnblLOpIbLJwzLeNosJlPyNUHtcN7Gr
         vL10Mvu39ztvpjSEcDEyYSCqFo2hHbSkmpSr+6HPLHflK5HgB6S8K9Qo63cpOdw7ki48
         0/scid6pNFDoddoFaK5BArCCE34CSmd0l3AWbG6FDIsA4vWnB0bT5VeYtK1uvYJF2PEQ
         SxUw==
X-Forwarded-Encrypted: i=1; AKwUvBwGQFX7gsgB+0ZutTWUmKdhnKDBgnzZXHW8s4dDun6M0s03g7R7ZEMA24wHao1908o+uZhC00U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3HYt3NKacXqIlxWihmam7WvYpgFJlc0nkhqMeJIi/itJi4nCS
	5dbrcKLeKr8D2DZF0lMD1eBSJABgrjQYk6EPLsLxQECz3MhoDVku5IIn5H2mnAYc
X-Gm-Gg: AYBFou1c2e6yOhb31K79LTme+izeEstH9Qn6CyfkXJ0pZP/J8MfIeiFL5e5L37L9kyZ
	KingaxCB0ahSpMLej4UaebGbcngpfvg4s3HtOqGyP1P0eQL8h8OrUMNwDyklFqSikVrvn+8FT+k
	hZpC/UCeUPoKO4aplhkqpBd2ErCjtmXc/avTP3cKDCtIIPUOCrm/4CQtQX9c65+En1s7wmF0yxW
	DK6m2jRBEQ404hscZPg5cMb6thUrfhb6FnRZ9DV4SOn3MSh190UzsQP456+tvAwGMZUmp2PqD9x
	gryJzpBiHaLxzYnVHRZBGi8iijtXuK526hozfx7/0MTv8/brZNb1oLwlst0SZ0gYjjzWjx48OYR
	SoL3utt9hxvke84OTpu/IHoZv/kQfgxtjW8v+xweL5eNVYsCvhvX4WgizPYbCLHq4cQQj7XlIxz
	ubOUw6hwJVVH2LD6h3IO9VQZO5qm0Z5EowrF3/HE1gce80Yvisuj7RUlWDcx0zkGf6hHRVxbcfz
	R3W574qyw==
X-Received: by 2002:a05:6512:104a:b0:5bc:f2fb:f4be with SMTP id 2adb3069b0e04-5be66a23f9bmr431809e87.6.1792483514495;
        Tue, 20 Oct 2026 01:05:14 -0700 (PDT)
Received: from grower.astralinux.ru ([38.74.72.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a42b330sm2424863e87.15.2026.10.20.01.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 01:05:14 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: gregkh@linuxfoundation.org
Cc: alexevgmart@gmail.com,
	co+0ea1ac045375cf05@bugs.sh,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	xmei5@asu.edu
Subject: Re: [PATCH 5.10/5.15/6.1/6.6] vlan: require the MAC header to be present in __vlan_insert_inner_tag()
Date: Tue, 20 Oct 2026 11:05:05 +0300
Message-ID: <20261020080505.279102-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026102010-hazy-clear-1f06@gregkh>
References: <2026102010-hazy-clear-1f06@gregkh>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> just a friendly reminder
>> 
>
>Of what?
>
>There's no context here...

Of patch, which is first message in the thread
