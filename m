Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860623;
	b=YIIKCSGU621h7TTHMr0Uu+VQzvrnNC5OS1PP4t2h03e2Y8eXV7h2770xjzHDssfVqxwN
	 ueMtPwtUW7/97R7FjV7ODLAIYZ7sm8sZKBZimYI1373IGHZ9BfYq+VHLaMiKZupMbqBdC
	 HOcAY+RUcWZG4fgy0kmqQAHVBkAX7y8y4RhnAiqhDFA6X9M/GSBAfbON+H3CHtdXnppIP
	 q1BZPPUJ5LFrdYOk6FxwB3B3V7+OR1vDxfrfjI1wGp3J16/NS10UcPoElnC9ID54g+LpI
	 EH+AKeYzNKPNuKHhuL5q0Yl3UpWPfo8KfS2dBajYfthVlgzCxYAcg+b2Or/iKxGPs1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=V9c4JR1l1BlqJLMhXPHekxlcKPXrrtwIQDnuHY/ovTQ=;
	b=LbF/8yBhRhRBF94m/i9SYEfeapdOlAm+GZ7sJpTIE1hhEgbBowQx1YkOHvInR5YWrG/K
	 uY5pRUo6CTxoe2+DmcbF2MW9Wfo2BuzNezSIE5FKPdycEkmhk1eoWhvpw0C8LmLMtFDUA
	 wvWnNwIJfpRYdxtoDR26QqEffloK9FelOBHEX+niGosV2Wh8rmyqHSjGQYf/7LJmSaE8H
	 4SuDwuodIV55bW5eT+p2I1LdNEOCwoNVo2bwOMx7/Ux0L/t6mEWgU9NMrfDhgMLN3WBQ6
	 AbYaIADLKdLrOJX9D7iXi7+3s7SyMpZWw7cndxHUSqUvLO8A9pBvaOcFfd9iHqUjELQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zQbT2rru;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE839606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 06:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE839606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zQbT2rru
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3514b90bb89so2944474eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 22:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793860622; x=1794465422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V9c4JR1l1BlqJLMhXPHekxlcKPXrrtwIQDnuHY/ovTQ=;
        b=zQbT2rru9bBYKGciF+LGs+SL/2P0O5Pz1jnsY0Wbxy0uWYPZ4nHVsnzEoGd/Hx+SuR
         kdzhheEOykq1+jWx94FFifxG1h+uB36na4yB+Me0rGcz0CxGX5bZpyh8fBnMPf4w2uQW
         ld/F8GGJYk4HRazfBRFBhJmcSwQRDsibTxJJAfaQ6Rw1B77d6xEXVkdlY2TUngnYbxFO
         GE4aFtA1vpYYUm1SytHyUnotHnoIReS0BSMIWfNvRL7HgI/FPZZ3JoTvKyGrUW8w6zGc
         S7Hr2yt7k0BsOgSD+0mfcAnoqRzHcrjum0L7Dx8JYFXD2TSYsX9fi0jtk9F5f9fnYJWd
         9eEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793860622; x=1794465422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V9c4JR1l1BlqJLMhXPHekxlcKPXrrtwIQDnuHY/ovTQ=;
        b=SJCHMOClJ8CYmFu8korh1n99wuC4Lj6SGYAtCsvhGfgt/amU6XvhaDJ3xXuMq8v7nj
         tJgd+Ko779RjAPexsV89pdRO6jmg4jiZq9B0dZGjx9dY67pQni/y8IuI5rY1IFblEYKZ
         EKFxj2R+S+PUrFMSLc9MheyVi7qKSbloR/rhCKgigtbgSqyIC1L+fwgOYiOTUVUMugiM
         1u2PgIwRyvpaBWLa3DJxQSZvoj/E9YmMRb1LVUEa58AJlnxSq4ltiWZn7MiqDo7iKYvH
         uQYcB0r6T8g9/XHeYjbxiiztI4gWN2iLvY/s0y3DsSDhAmnr3I2PWdKYRc6IUvNX0dGP
         bpYQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMSzQz1RnR334eHVwAsJXJkflSdU9BWnIlhc0b/khtUQ8Ua/xjGh2k4dO3aQVAsAyuQ2SN6kc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7pj8cnvNbpfJXELP5kGE+8/HJYhuHxkHoqGP8sL+SnXwIccIx
	MtM0v5Qd2N0VakdUMi8QI6D0UnS7AsRHewW1FDu7bJ1W6uPS3CChKLbf
X-Gm-Gg: AYBFou3mix2M5kB6cHpXCZK66ZkRzdl+li9eMPIIlF6G10G9XU7rCULL49Pdo1Z/h/y
	Xp3zWIA89WvOk82C8h7L2wdqeHGXwHzRbn6dBzsry7Nfv2TiRZomSvED061MQOZ1XK5EIUPKFIQ
	+aQO1wVfLttS+/Z5Guo8tfMLc6UwFBQyqUqO0tSmbTstlSqEvbuy9PSVXqqN5YijYTTnQ+3okB/
	Yc2Ac5UeYmz/0j2BDFSzBUPiBP/x+MuqHsMr2bO9/aADAMLyjnFkO0JsLMhjSsw/hnpDCkqXg8y
	d6TgvOwBWVVjk+dJ/AIz86tdNdysBt55howLC4ZtnPMhA3IThBuTWM0K+WxCoaU5eBtJt8mBnsE
	qOtB2lbt41ht7XDL9nsk6jPhcpwFg0Rc6zDlciQrpXk5BZ9EVjZot/vBT7Ht+2uH7z0Z2I2l4n+
	Y+8wJXb0zGoNg1SYF4519zjtHRLU7PqQ92eT06C1tGkgJMLfImDILXYpgBheejb6S4fsXIA7n8G
	sPJ7gl1btjpkzDBH3oDqeuaC83J3CdXKLTu48VA7WUDil6fD4RqQo6CY0TPzTYUu4mYwZnwF0Jd
	E6zdgaAU7SrvkSbNMfkcmRTX8lEqxPGg/aZs2N1DYr++2mp/Vw886A==
X-Received: by 2002:a05:7300:d58d:b0:369:e8b0:af85 with SMTP id 5a478bee46e88-36a4243a512mr30366093eec.36.1793860621499;
        Wed, 04 Nov 2026 22:37:01 -0800 (PST)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36d34d5960esm13148900eec.5.2026.11.04.22.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 22:37:00 -0800 (PST)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Xiong Weimin <xiongweimin@kylinos.cn>
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] vdpa: fix typos in comments
Date: Thu,  5 Nov 2026 12:06:52 +0530
Message-ID: <cover.1793860522.git.hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261102043526-mutt-send-email-mst@kernel.org>
References: <20261102043526-mutt-send-email-mst@kernel.org>
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

v1 was a single patch touching both drivers/vdpa/alibaba/eni_vdpa.c and
include/uapi/linux/virtio_net.h.  Michael asked for the uapi header to be
split out, and pointed out that the eni_vdpa.c comment also says "ENI is
build upon" where it means "built", so patch 1 now fixes that alongside
the "specfication" it was sent for.

Nothing outside comments changes in either patch.

v1: https://lore.kernel.org/all/20260904104440.18772-1-hemanth.selam@gmail.com/

Hemanth Selam (2):
  vdpa: alibaba: fix typos in comment
  virtio_net: fix typo in the ANNOUNCE_ACK comment

 drivers/vdpa/alibaba/eni_vdpa.c | 2 +-
 include/uapi/linux/virtio_net.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.48.1

