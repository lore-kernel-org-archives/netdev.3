Received: from mail-wr1-f103.google.com (mail-wr1-f103.google.com [209.85.221.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2BD3B5312
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678637; cv=none; b=VQgi2oeaMS8IdYEloxcfEBAMIgAa472qnOWGWG1LRqeFI0DyXOSwune3RQuHe1vVGL7xwveQDHED/1BJ4CCVX2zOXQwzhlo9Mb/A3jPJnvTKpahp9f4AQm5Kvz+SgbkOuXjbARSC/dfNbm4z/pC2kQoNhVQ/zkg7qyzBBpbvf+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678637; c=relaxed/simple;
	bh=fuUjAufc9frlAw1lUECQdQ0UVuzBVzySv83Nfpdvm/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uEZdtNZ9oSNssUuY3IkRlLllbIwAyRDNaqWvlghSramDKMUTZd4cdxl+oLoWcqzm9K96ptV+NxtQz+eC/s9hBozdIG5L8zDxrHEQ0rs5Jws56eRtnENhk4zgm9s5DlXaS50bIbgxvbHBhDhJmjchPFWk6g6LR0V4qS5K1S6Vk4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=JTR70VLt; arc=none smtp.client-ip=209.85.221.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="JTR70VLt"
Received: by mail-wr1-f103.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso3811772f8f.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1773678634; x=1774283434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5p3gsIxPQVOfXPfqPJJWIKHuD6O2URWJsyp0o2Rhwdg=;
        b=JTR70VLtsI7Wqg3mW3whK4LGzumnSG7y3xifZXoBoAn9qIkhZpZHqMb2jr1b52cPdd
         7vbjHH1IvJlnddJEAs7z/J6zvJUvjAK85SdO08DTj23n49arwVyzcwkSmSvHIMJ5lLOR
         7bijtKg6eO8hfc1nnKwtTLLRlVgijBhmUDJLru4pvkX3or4+02sTkmVDZJFrxY1FoUkP
         GFu6CAUcbqP4tJlwNAmpb6fa0V0k7LE3HOpLXWO1iTVeX+0ZMCIN4glr9jAISM7e8Rh3
         5Sw28Yu4kag8PUUrh4z9O5XzIWqgbKZnqbvU6QR9ACotqhw768K9BoAk8SfTbbQz/uHP
         XpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773678634; x=1774283434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5p3gsIxPQVOfXPfqPJJWIKHuD6O2URWJsyp0o2Rhwdg=;
        b=TbLUrILXipP24OnLlei9hcuvLiXgbEiMpOfdlvmqV3qAwu1Ov+P9QqXMUyHrGVtY9c
         HFNkIdcGDQOHmjFmwoz7+dYEP6USOW3/iA89j9+qEkcLjBzk27QD9HSqRL/BUOWEES5p
         bzt4i9fyX8U9n6VlrJsbOEkzetrmfwYm34PXgHxKoRMsEYPY4Xd/WKqRMN+LTa+DD2hD
         AYNX5nHSV+hTozZVOjf9PcR4wNf1mCxqjGj+sMieBM78U4oLbZaCUMoPP5IP274aFrjn
         bZv2Kqb2kWMXg57K6lSg2YS46VeBcOMJ/JRzn08tDSGl2WIZD2arlwFmhP/nmlPhsnoA
         FO2g==
X-Gm-Message-State: AOJu0YzyOYnwsV0I7ZRM/ccXkkp+GcP31jGX93xhNA4K1c5+DvFhmo1e
	kg/YpIfP/6vUWIrj6rIlDxWeS4JlHhiZ6W9WtTEdEeWgDO6Ia/pRKeeL4ZCNwFii8XOKlRW6ri0
	nkydxxYHmKu3WmLSnqfS1f9S4VeMt9YfQalQl
X-Gm-Gg: ATEYQzyNoblgDHk6NIcw03+mOS8+QOC/GilsgSmTTSrnNO+Un5JbbCR9Wn+OPOJdnRE
	E/Tmfqbs3aNOPjyf8zdWs+NZ2hydCE5Uo4hgvd6qj1WvXSML5JvcMPlS8y4VsTfKZiqmp9sl7tW
	wqQaOqgTX4yM068RM1OsHquHIYxpkG1rs8y0StFUzhIcYKao1npQuxJu2BmoX+pV1GLTu09poRQ
	nCl7ngeCx69T/pwj5hf//YOPXnovPhAtQymmv0huOfTYukKEFgYu/I/U0D9vKArgcAzdy4cMPln
	OMBR+jjXQCJNzX7G2LXJxX39sTwdLXnXKo0oxL8EinBOCu6qNVmWBJcn7AqjjmWvaawXInNrnfA
	sxDA2eqyPtQIYe35pt+GefSOeFq3mE7+lg3CXX0Z49ma4EHA+UTXYIkW/k1H9KgbDC5Mx1Ncehw
	==
X-Received: by 2002:a5d:584e:0:b0:43b:45ea:824c with SMTP id ffacd0b85a97d-43b45ea82ebmr5062636f8f.26.1773678633560;
        Mon, 16 Mar 2026 09:30:33 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id ffacd0b85a97d-439fdf0895asm613655f8f.0.2026.03.16.09.30.33;
        Mon, 16 Mar 2026 09:30:33 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (kadavar.dev.6wind.com [10.17.1.232])
	by smtpservice.6wind.com (Postfix) with ESMTP id 522E719F77;
	Mon, 16 Mar 2026 17:30:33 +0100 (CET)
From: Justin Iurman <justin.iurman@6wind.com>
To: netdev@vger.kernel.org
Cc: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@gmail.com,
	nicolas.dichtel@6wind.com,
	stefano.salsano@uniroma2.it,
	paolo.lungaroni@uniroma2.it,
	ahabdels@cisco.com,
	Justin Iurman <justin.iurman@6wind.com>
Subject: [PATCH net-next v3 0/2] Add support for seg6 tunsrc
Date: Mon, 16 Mar 2026 17:29:53 +0100
Message-Id: <20260316162955.1253225-1-justin.iurman@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the new per-route seg6 "tunsrc" parameter.
Some tests are extended to check for it.

Example:
ip -6 r a 2001:db8:1::/64 encap seg6 mode encap tunsrc 2001:db8:ab::
    segs 2001:db8:42::1,2001:db8:ffff::2 dev eth0


Justin Iurman (2):
  seg6: add per-route tunnel source address
  selftests: add check for seg6 tunsrc

 include/uapi/linux/seg6_iptunnel.h            |   1 +
 net/ipv6/seg6_iptunnel.c                      | 114 +++++++++++++-----
 .../net/srv6_hencap_red_l3vpn_test.sh         |  65 +++++++---
 3 files changed, 134 insertions(+), 46 deletions(-)

---
v3:
 - add selftest for tunsrc
 - tunsrc: forbid loopback and multicast addresses as well

v2: https://lore.kernel.org/netdev/20260311152845.278354-1-justin.iurman@6wind.com/T/#u

v1: https://lore.kernel.org/netdev/CAOY2BqxUswHYoisKjABPunMUC5QJ-B-O9aXu=wKrhTZaqSqedQ@mail.gmail.com/T/

--
2.39.2

