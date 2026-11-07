Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794031600;
	b=ChI4FqPzIeA1iDZZSqvR2ZOxOlGeZKzwgbVoSJjVSEnFlcdoVa6BPta5Qy7rPSD1o5aW
	 27g3BkGP0iJEPPSMqW4Yj906WLh3W6MS4cSkmDBxiXx74Km6v2XGzBYAEnLdBdtg4gF5S
	 11RQaS/sNB6ERfPctyJa5lF5d1dhbTweRKylQAu326URo11xOMY2/UWgP4yMUtXGi2A1o
	 mLKm9xkFMSw3NcsSdE6lKRKJ2/ZKgwOstT04BQ96B+8mPR/9j1kxWQFo8Y7b/iPn40KCb
	 ucFzOqCeG2Ydz4SSzF/LrdQ0RMCBHG674bMIcxnwPy/hwV/JFezqJEDUYl1rbPEHTWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794031600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=IbTXKYhTg4UDz4yQdeuAV4pJ758Mchv9ycf3D50REY0=;
	b=NUJAEuXntl/uecJvgzA/t9scEzISH5FIZK+T71og+9uTvZ1KPkm5KGV8Hh0/d/aUvqyK
	 N9pYJwzEZuDEQNbzAf7vl5Qwz32vecZzuBYwC9SU1tmN3IIUxvRA9qfx/mKD+MnF2bdaB
	 BA4hVJtKxUqEbnfjhu0IxxCFKhUY8lrt1gD828pSb5sTE3fZe9ihQnbFbJXz5OGyjKorK
	 C6xAc+CP/l6LC3fXX9r6FusdJfPp656ux+fOVRyTQfgK5MojtwPOBrPD4E6ZwvLGRy5TW
	 EC0Jel0UvPrrtRfoJtsuvDN075S3+GxH7FHS8cBIbzkmPO8N5cpV4bqrMDMVpVqH1dQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="q/7dWNdw";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2333E606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 06:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2333E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q/7dWNdw
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-43bf9548df4so1215940fac.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 22:06:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794031599; cv=none;
        d=google.com; s=arc-20260327;
        b=r8/zMW5Ny1ubctMjSBBuI8WzSe/nrMTkvvtQKHiCB7MAKuGO4CFfbMpm5zGbfDz2pk
         Z7iJeWUQou6xmAggYKkvDfAYUfaX8H/t1mJtRDXUkEkP16yGauHXM0ddrKcieIlzvggh
         Lg5PlEmwb3MfUKYhL1yA09iqQn4G6H8RXYvJ9G5A8hbhuRMtotm5c2BC9ZjLMn78q8q3
         CU3qU70VlraKeHyxI1xIxNjKkqeomIDanHBsbqAdGIAUQXOxMiBLwZ4s1vN4qz7oLsPY
         OnKaUXD+ZK98u1sUmbwXp6Aefbx3CVbtZ7sw9RnN/s2WJAT0iMlxflK1MSd1C3dFH6yG
         +vzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=IbTXKYhTg4UDz4yQdeuAV4pJ758Mchv9ycf3D50REY0=;
        fh=y62OM90oLmeP6fwlP9BrsvI3PdqGlvcMdcyeZBjLLpk=;
        b=ENwRRugP+37rlABmxyNt3D4ddgrv1mIu4U5idnXQDbIQ66C4IjyuvZJAPrLj3iroR2
         jEoiF6htDUHIc/e/rUWzpyIiBF8Yw5XGbQ+8gtTfnJms3/g05cf6Rtcl8noUwHCeQYuB
         EOBKedwX4emLFu9ewxiQuoRu5pXL4FSVacijOOnZjn0bJRiEiqyNPZHsBbJI47dxB4bj
         DUB4vheCcUZ7kPi5P40olhDfbawlMuWbpFSm+7LR0oOzisfPNDFKx79osNUhqSOyophH
         PteIb+NzgZ7AVLg7+ZsBNowtipah5RKFXPout6MxZ+cjSHWA1I3mx2PfiC9924JS0m5Q
         GFoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794031599; x=1794636399; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IbTXKYhTg4UDz4yQdeuAV4pJ758Mchv9ycf3D50REY0=;
        b=q/7dWNdw003NwmwZXnvlv7VO365y8zNcVd0MPxkKzeNaX9Ksq3LCD/80d4DKzhDCF6
         IZRpO5bWCHMSSEhnc9MqyEmf6uSyzj7jgnxm3F8x/63kXS+xlH2Z3d+WNLWhoRF7K+FB
         N7/f8hAefAwArQNrLO4FWfhPm7MKhjnRBauNRLKOFiBwPaOTBKIv2EzTrP2aNnOEQux5
         vYFE3nlTQu9aAAHQo92Gxk+ag/bFRJeTY24X2zRgrv1M4igD5iKGjefTDmJ3umUdmeKG
         735kVziiOc5bYAPtNH2kthGmUEXnjL5+nymlwpZPrYIIffyTAi/hA9AsU2kTb3Y+lo11
         U6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794031599; x=1794636399;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IbTXKYhTg4UDz4yQdeuAV4pJ758Mchv9ycf3D50REY0=;
        b=k2aHm724ZoNb1+Um7GZ6XIyt4OIoqIgKujb8vB9HyrVi6eh0qMR6+KjFm/6qA1RADM
         8PI/7fTGyi7iX09ns+eun/LAyTv4oLUN61oHVnBeXs0GmJuMAsPioWVD+32zfIDCFMIn
         8cLqBfNtWG9c7e6dJ0jHzwaCzKKpOuuZp14QUhpyygHCKdqU2JTXjQqz+iVjL6MATqcc
         IZFHK9BYvyKoA1ZPgmrUB0pRpU2LEhAjfFRDVTEqZBtPli8jcDUDQ7jdtU9UeYw5VleV
         Hmy2cIAz2Fw5OXu0rbVwLFMllS/Z1NmI6RgpiyOvb5/Bi7rew2bEXA1vUHplG7YVctvI
         u2bA==
X-Forwarded-Encrypted: i=1; AKwUvBwz5Am9LUILzfeF8XdWA72Lo1njRYXApWD4JKfzox37xauvL5vzRs6E+ZGZmyiyOPUdRnd7Y5w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lz9jDyr1keH8g1VAXfckAKkTJofJzQLViLWzPycQhnZVisya5
	eskLBc0ZXa6/ok8kYESJDEK6l2XbZLU0pr6Ylfut+Q34et6Y+G02BmF+rg1legIHTcCx0ovFP/W
	ZcLOk8pmPVQV8JFBx+1mrNid+3D3wUDA=
X-Gm-Gg: AYBFou0kITFPy9XIkiSFcsS9Png9Dtkp6606x2x+LznCvZgWVl2hKPmTJ0QLHNVE+qE
	L3OsIVAw1nuWpr5LAOR0BFSHUM+TVG7MnRgq8C2my+swMY/lMv2A+bT5yAC358DJq+NlZJXn01N
	pX81xCZL6RDb2gQolOFU+0maadInagxesrNlYTpWXk/+98E15nXc4QKcsuZlPH7tts0U9yLl2Kq
	s57UKtQwqRaIuZjr0ir4QaRloW5tmdYGIi3bOE2Vl+Vq+JxGvxbywoBP+8w9sV4fDP8pCtCT15S
	SiI/RXP5JZwUi+aLmSkp/EgQvaQih+1EIobS00rsFYqf8Rz1MrlQh1J/hsPMvGq+iBFNnReHs+v
	2Zhuh2GvNKjXSTtw4TMhOnMiJAOI33luXoSMXOopUGKsPiZf+DqqRzmxMbg==
X-Received: by 2002:a05:6808:23cf:b0:564:3bc3:4605 with SMTP id
 5614622812f47-567e1535fe1mr3335044b6e.40.1794031598913; Fri, 06 Nov 2026
 22:06:38 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 6 Nov 2026 22:06:37 -0800
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 6 Nov 2026 22:06:26 -0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Roshan Kumar <roshaen09@gmail.com>
Date: Fri, 6 Nov 2026 22:06:37 -0800
X-Gm-Features: AclHuK99jKENmsQSNXDnKdu7CcWNmvDQnx-3eEPjLvKurMnwi59_003exdfncjk
Message-ID: <CANphZRNSXy4tQ9jO7RT5g2X69T-CapR3-sSood1qJfYTRUE8ag@mail.gmail.com>
Subject: Re: [PATCH net] ieee802154: hwsim: free PIB after unregistering hardware
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yousef,

I independently reproduced and tested this issue on current wpan.git
(2b4707a149a5). I also prepared the requested rcu_access_pointer()
update. It passes checkpatch, targeted W=1 allmodconfig/allyesconfig
builds, and 200 KASAN teardown rounds without sanitizer findings.

Are you planning to post v2? If not, I can forward it while preserving
your authorship and Signed-off-by, adding my Signed-off-by as the
forwarding submitter.

v1: https://lore.kernel.org/all/20260627235805.17310-1-alhouseenyousef@gmail.com/

Thanks,
Roshan
