Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718E1217F33
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 04:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784954066; cv=none; b=pj1TRHuk9X6g/9azHzjpekHNVSzAP56wO1zqpMOZLTkA4Y76G34I7bCTirU/fxVuZYVY3IOB2OO3RR8JBaxN2kswZWuSy+flzjimbYAbneNSHKt/hpXXDU3tu2jn0CD935iNbtOlbHFDbm5MhAuwoaS4eObxGUUKHeFOsTdprAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784954066; c=relaxed/simple;
	bh=j46+aAQE8kPVlhuyapHUWKhm5a+J6dgegQwTuFZEvnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3vcJ1zwed+rKG9uo77VnVfkjsQuu1fJWjYfB/fGvjRjaZQN2W+9OtJjWN0AaQwYKneLt0N6hRqj7y4PpAplHfyDU6rj3/Igbwvk444ysyxYv3/n1oca5Xaeb16dZ0JEo+7kiVhVkXYqx2s6U5sf6jxEnXUo7nS0ALW52evDYUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=autn++XL; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="autn++XL"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-80e24970f1dso7048807b3.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 21:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784954064; x=1785558864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j46+aAQE8kPVlhuyapHUWKhm5a+J6dgegQwTuFZEvnM=;
        b=autn++XLY3mj90+2l9ok89TE1o9YKCsFBH8tfbLDA7RXUOG49+YlHQFwyQflUy3NFh
         2Synci7vRsUEnaoBB/9JwV1IcrS/9woA4MjSc7JJPqoNWIb/EH35iJyAZQG8ht9eZlFG
         u/qQ7mjwCKrkZIdmBqutbBEO28vDm5ew0AwV21ZmxuvlwNpnAKcYFlEco0WhZci0+tU6
         UDXynz3lNQjDkz8TBCTUnFGcjJA1aXQ06RzdouXL6KOgjah9Gr2KpKml5mwgougwezUv
         9M7rKd1ygWLPBRtSs9hCFrZDAvhrpPymtmkoUqTfxE34Mcvv04rT6LEss2DuHVegBpEs
         UV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784954064; x=1785558864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j46+aAQE8kPVlhuyapHUWKhm5a+J6dgegQwTuFZEvnM=;
        b=VP7YDzeP247kPpgPlKrSlTu0kcVJIMYEWsXqxMoGhCGOrjVfPsxm+h1UnglWzH6Ng3
         AUw2nugtZDZ9GBvsIT4C3n5dUW3e5aSNGvJYw+ytpkRFbbyOCKjk5s0xcBrLygiMiI0N
         XZgCP/nUJWwRPs0FSwQjnP/vcApd1xAghkZ1fMQNm7JiFdnYtArQXn0ByBeIZFNAR7Cl
         rJlKE/D6WdJtuQga+/Dho7ZguK1LkhQi1x8FNa8+P4e1jIqTaDPY4Iw1RZZCdNqcWmok
         +vzTUKH0T2Xa3VWdigC7uacQSNXL39ngLazVLBQZ3BrdBw+eYjOlPHiQqpW5r/SyMTdV
         QrSg==
X-Forwarded-Encrypted: i=1; AHgh+RqeMpK550Yz7uJ7pX34x9lilY6pk6SGhA4ZTUdw1BNqxEeVclCo174H4DC3byeYX93/hiF7dyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEJIEqyKyeIitdk0oolZj5sgAqdnERxkDpE0PiqJ8PGIzcZICB
	4Dutx8Y3VTAnEHOhTma4MYWNPBT/7wGF2W+hpyz9XI57IkQieKJLgMlM
X-Gm-Gg: AR+sD11hcu8850dBmLKFzN4WOz8G+omgWYcc7F6s4GSdgdbgxdOnbX15obQEkbPOA6T
	LDRIYBZZNK0XIT0PKCT9mVlyUoMpoaUk99Jp8Szch+X/q30I0Nh8pXlDcCEfo6un5OBs2XGhuMD
	fg5P5Kp2k4LPb2NTuhmrKXzZHx85Rt8mo7ZCLjTUqKn5T9OIEmmdioDG6H1oBt54+O4c3dxtTYO
	A0ywhTAcSZmJxIBBf1CerFkxO3H75ONwOzFJG5rfprQu6tPgmW34y6WDn49Mfxn2Qi68zh7Y4QJ
	A3wA79DPZNTCAMKkhM5dzIISRdfAN7J4BU93rO24U0jx9MhEYbulQrSfipzYSXX8o/oaiOai6ZO
	/wTkOVuNQRYzmGv6e8PNFa5YGWbgLu6SrYJmwJV2w4lgSAMlxsz/qO1u0SmYGOqi+vL7P6B8kRO
	1mnV1j/ER5JJTDWrsf/LI/2FgNRR89tiIgjGnBjnU+OYFYshT9snXwLPl6YW9E32NJCMYgcBvrm
	LYkGArllsuHSg==
X-Received: by 2002:a05:690c:4987:b0:81e:8f3d:1d9a with SMTP id 00721157ae682-81f69e2bb28mr3609617b3.39.1784954064420;
        Fri, 24 Jul 2026 21:34:24 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65770059sm8837857b3.7.2026.07.24.21.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 21:34:24 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: i.maximets@ovn.org
Cc: AutonomousCodeSecurity@microsoft.com,
	aconole@redhat.com,
	blbllhy@gmail.com,
	davem@davemloft.net,
	dev@openvswitch.org,
	echaudro@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tgopinath@linux.microsoft.com
Subject: Re: [PATCH net v3] net/openvswitch: check Ethernet header length in key_extract()
Date: Sat, 25 Jul 2026 00:34:23 -0400
Message-ID: <20260725043423.193279-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <efa2ca7b-ee6c-4758-832a-727c7c417c04@ovn.org>
References: <efa2ca7b-ee6c-4758-832a-727c7c417c04@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the reviews. I've sent v4 addressing the comments.
