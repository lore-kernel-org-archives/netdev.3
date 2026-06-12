Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E11337DAD6
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255966; cv=none; b=QGkJyjKlZxtjR6Fetq2M3cp5D4DlUO5NRruaTqTs4sn0ZwDBS0NBVWCAN7HTCPoWo4DfUroZnxHFaly0dETU5ejeAICqdEL4QMfpfptbtLxJiXdP2nZ2TYyf6f5piVM4naxfx0qO4JqYEEffwf1APNG30anZoWUu3Qua9dRQH4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255966; c=relaxed/simple;
	bh=XBhUm5oNG/4V5XFaz/nHzJDBTbfZxuhuiSzQWvfQZH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPOy7nRVr/3BZROjw6PH7Ys7b74kuX+yt6a/mfMqKxe5r3G09Xz6SR0XmdPCzporOVs3gcjC3gX3hpuL87LhE7CKw2gaD8fILV9rkluxJMaVU8ZkVIsMquMU9S4TYR+9qRuWomkHl/x8FXi41rq0y1Sh8VNy89eRojociUYPF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTJnFKdB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTJnFKdB"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36b9033d230so484574a91.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781255964; x=1781860764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBhUm5oNG/4V5XFaz/nHzJDBTbfZxuhuiSzQWvfQZH8=;
        b=WTJnFKdBZZO5Me5Bls4IAGj1mg99Jsoj/6m4mUFzXcBEIvyNyju1KBfxxIFMjmZnmP
         V1BvSEPDsPXiNdVF7zoHrmtAyaMQULo8hLARFtpvn7gAKmM5/Pe+LTta6taI81eTJuyg
         7ZyZx2z3k0GHdak882LYHrw1sZVNVvZLkPhb/y+SZCL+1cMU74700oSdFA+kjZk1gsfp
         fWsPtuztQv7ly9D8G4lDXtSC9/3Ro/w90mnPsiu8t8qRaKGeG5VfvfuTZK0X/6SdFD/X
         /r3zI93q3RBWLxXXjN39E9ZRAZIDo+9XK6YN6hL9LvrZEeiM0UNDGSq3JkJ5pzC96kHb
         FMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781255964; x=1781860764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XBhUm5oNG/4V5XFaz/nHzJDBTbfZxuhuiSzQWvfQZH8=;
        b=D6K7RJvawlqVrUg/AD1UZvNpdcwsTffonw1W/JeF9pnC87JX6mK2U/PNOqsMku82dn
         HtP2caaLbbp8RCybs7Os/N+k/mPBYiUEUXFAkL1lgjNsD6tabCwgRhxmFr/XZYmu9BV1
         OLXe5X6+gC7+fxVLpphVnXZZPave0G/A7Xy9oRp8AZ+WX0oIrkpFhheYZo29mx+G0NBV
         5EEWa1I7TGnY8eDD6ppDLA/i9lRK1rIYnd/9CVJ0jZLZDGf46/cKzfk2fctFYOFZAzHv
         EydhyKRQi+MctDHMDTRS/uzFRi9p9YBTW9UB6cCB6sgevHNlw/PTXgmOaNkgKsNVKbl5
         gZkA==
X-Forwarded-Encrypted: i=1; AFNElJ8dkCQe/U+l3oM13wR8/G/mzc0eX3bHn6DUBnoA9hJmlmBcCrveW17dp5hvccAB2t4rhCNVjeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5h7EywSjfK5CdSxQErinIjs8OiIL4L1mzVFXSiZ9wpsfLVE+K
	p0Zk+5Ep6iXjVzLUtjunAo+cREGOgRr1lBNNyLTBb0uBdt0bQuZ24sA=
X-Gm-Gg: Acq92OEUDTvj30bTibxtvuMiCGO24aMl/o0jgqkD2nU2SpS/jGRVSKHoH0xlLR/zHwD
	QaTonClNK9YutAcajARDgOsdW/zF7Ecn2wd1PaM4uG2DSEyNJ9e7G2NWfCWfk1e38MUIJOTY92W
	Xs0SRNjqWqfii3vL0QQ3HlPfYeyMwC9ROHsO34vCk3P4b/8Fr6/Bwb2Um1mQNUrvdEk3v5lASdH
	c89MeGyc+8rUmQp4X9C3VPWde+RWRbEoRtxZbUguJrNHvysfFUTMe9BxO14L7GL3mJpS75SZyyY
	FYEEMLYhiaqfb8H08CyPVh5XqxALcPBAA4V4ijx6f05N0xJjTcPsN9AfcYO/6UzUAWDNR9GNecv
	APr0RKCAEqytXB2aOrRjevWt/JT1/gu5BFS9oLaB6Vg7KO9XpTYgRwMqFJ40+jxieZ5qFnhFAA7
	sWL00Q1FYfHuaBoemZQK3uQHZjYwe15clTvzbHeNfZwW+aooOSyRHalrBls770fnbMTIqvXVpJo
	5lP0w==
X-Received: by 2002:a17:90b:2249:b0:36d:630a:c4e4 with SMTP id 98e67ed59e1d1-37a1d730d3amr1317761a91.3.1781255963615;
        Fri, 12 Jun 2026 02:19:23 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e810f98fsm757816a91.2.2026.06.12.02.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:19:23 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: sgarzare@redhat.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	bryan-bt.tan@broadcom.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	leonardi@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	vishnu.dasa@broadcom.com
Subject: Re: [PATCH net-next v2] vsock/vmci: use sk_acceptq_is_full() helper
Date: Fri, 12 Jun 2026 09:19:30 +0000
Message-ID: <20260612091930.466896-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aivKma8mRjTXV0BM@sgarzare-redhat>
References: <aivKma8mRjTXV0BM@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jun 12, 2026 at 09:03AM +0200, Stefano Garzarella wrote:
> nit: title should be updated since now this is not just vmci
> Wait a bit and in case this is not queued, resend with the title fixed.
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks! Will wait a few days and resend with the corrected title if
it hasn't been queued by then.

Raf
