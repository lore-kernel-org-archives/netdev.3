Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FED4CCDE5
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201610; cv=none; b=NuZ2CoEf/+ZVGSLBud9R3RDLOmQj/RomcvthJQc/6+2CO1NPygFb/2btZcdG90B/2DlTJapFJzwJmI8g2HNAH3TcU0N+kXbsZxX2tF0MVyly9z3D+X7k+Xu5GPKoNYH4IwkaDsjFFErqD7BnxvGTFGT/CuqHqvxtgB6T3DvhFNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201610; c=relaxed/simple;
	bh=aewfOdf/3WAUvkkFdDrIdOFI2f7ZAM15rd2oXKGgb4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HAs1EMXKNtGHhkGrCERvd4NTbU1vM5f1zD7JOYmKortVvQ1jSEsk7qvPf76icbtETUqhd8/FpUVaNJbK5OX2jn9Q2zkq/aFZAkfoF6OUZGv4V8frvGDVBvwyIQqS0fd3U8JFimjajbXWmd9dGHCZ04VTrbJdh4fRSw1TmAV8DiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFakrzFf; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFakrzFf"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-783047c8464so2700277137.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 11:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788201606; x=1788806406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GbhZLTo9aV7ORbQe8pCNK+Oy/E8FGCzgPkcrwk0Y9GE=;
        b=eFakrzFfV0IJubLDxmDE453rSE/2KSryDLxvTR+E4gakW62mr3xDO2rfh9gK6guRiZ
         n68vIqpPvFrYWTCbDiZMxvgOnVGBQRreYlq/awGF/LrqTqVlm70kmWMW5jh0L5blbkOw
         qRk7ArZmAlFzUfq0dqyy8S7IcTrPQ2RAnZc65oBZVCoqGZW0Tif9iLAp8bp7nHB7i51N
         qwZey+mrT+jhAYmnqAJd3di9G6VbYmO+5RSE66rBhWRncGIHbpXjUH3dx9GnB4uzAlM3
         2IzyhfFqYaUdIgUWmt53iB5e01HuyKJNrHf8MSRDoJ6c0pOUUgORccN2XELadT48qrjp
         Yv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788201606; x=1788806406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GbhZLTo9aV7ORbQe8pCNK+Oy/E8FGCzgPkcrwk0Y9GE=;
        b=ianyH8vGP51+uz0yapIVbeBd4Z3UUP4R/gFXjKeGp4KMtcNMLKF+sG4pqsblBAb5ny
         BiWVLTRudyYxBoasqu6gLeameW3NT3SqbZ5bKtgyQhOj0HAy5B4tr3mebbP9VweNQHcU
         XpThZMJ2eFZkZw4QJxBRuIYoYHEhZP6k1cv6riicG96NkH3wDgTtMkSx+RuEhY9LhYQS
         jLaQElBAQS7bHKzMxOC3TlqSxac/E155DOVl2wqaYKZmDqLRV8qQju6n1DmpBWQpTpGM
         z4WQ3QXT/3jgM9O1DwSgY1uqsiv5oZG4fNFz1PobMLAPmSc8k7DvFTnqgAK6W/+Qm4zu
         /6rw==
X-Forwarded-Encrypted: i=1; AHgh+RqsbS4cmFyBpa/TWKsEnXWtuGRZgz+uGgYJ27nXUjnAViL3Bv7fXCO7KHBuiSsR3SR/aCLGvaE=@vger.kernel.org
X-Gm-Message-State: AFuF++mtlFRIweAZcvHjlFo1ItccI0Gltm7fkNA+WytwPXaYi5RQIojB
	0DrvajQ1aVN6r3MQqH83eApyuFU30UL8QWaueeHYWqee5KzRV4K7709n
X-Gm-Gg: AR+sD13HxHjAM54VzmJWsSnQ8o0ga7xiXU00uTJdDKmZ45DmJH6an23yG41Wcd6gtdM
	hoLydCUIkrjzqTtbNTRwGUevxxWegy04gnNWMyPkYBcBcdY8yJ5qa0mdFMGo8CJazI5Eu3euk0F
	stkbg+w/uYnsAUoCwjrU30Mh3n5FgFxlsMuCPuFNjpo/m4PL1N2++0mr7PJ62r22GFZYPE6YUO8
	LYpohmUvNvV1cs+Mq7B9cHYaudSeI3mzGL4T6BVA7zujBIeli2qk+W1YRMTt4LwYXZrY9Lnn1kg
	+rL18EPKu7PG0seC6RtzIc8WJfJUxPTRwaPW+6Xqst/AfHiDhP1Z6nLFp2GDwroIFDgBBcMcCBX
	30JvU8gISDe5lVyqDDkV0Xe6dOcEnff+yQQ3NSje5Eyaru/qwtjTpGNe/jzf26CAKU2lYZPJWSX
	ObqthOZD4U6ohWNO8iWJwgSZPI8sFQBhEDpjUrk/P161JxtIXIBJ5CJcjG07xmKZo=
X-Received: by 2002:a05:6102:424d:b0:789:3f43:6455 with SMTP id ada2fe7eead31-7893f43668emr6870967137.0.1788201606502;
        Mon, 31 Aug 2026 11:40:06 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97e847c49ebsm8747242241.0.2026.08.31.11.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:40:06 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	syzbot+989ff6506f5c6d1ff56b@syzkaller.appspot.com
Subject: [PATCH net] netdevsim: take bus device refcount before registering device
Date: Mon, 31 Aug 2026 14:39:52 -0400
Message-ID: <20260831183952.1345042-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nsim_bus_dev_release() drops nsim_bus_devs when a device is freed, but
the matching increment was done in new_device_store() only after
nsim_bus_dev_new() returned successfully.  When device_register() failed
inside nsim_bus_dev_new(), put_device() invoked the release callback and
decremented nsim_bus_devs without the increment, driving the refcount to
zero.  A later successful device creation then incremented from zero and
triggered:

  refcount_t: addition on 0; use-after-free.

Increment nsim_bus_devs in nsim_bus_dev_new() before device_register() so
the release callback's decrement is balanced on both the success and error
paths.

Reported-by: syzbot+989ff6506f5c6d1ff56b@syzkaller.appspot.com
Closes: https://syzkaller.appspot.com/bug?extid=989ff6506f5c6d1ff56b
Fixes: 6aff7cbfe7bfa ("netdevsim: Block until all devices are released")
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 drivers/net/netdevsim/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 5c55c308487b..426fb438b922 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -194,7 +194,6 @@ new_device_store(const struct bus_type *bus, const char *buf, size_t count)
 		goto err;
 	}
 
-	refcount_inc(&nsim_bus_devs);
 	/* Allow using nsim_bus_dev */
 	smp_store_release(&nsim_bus_dev->init, true);
 
@@ -465,6 +464,7 @@ nsim_bus_dev_new(unsigned int id, unsigned int port_count, unsigned int num_queu
 	/* Disallow using nsim_bus_dev */
 	smp_store_release(&nsim_bus_dev->init, false);
 
+	refcount_inc(&nsim_bus_devs);
 	err = device_register(&nsim_bus_dev->dev);
 	if (err)
 		goto err_nsim_bus_dev_id_free;
-- 
2.51.0

