Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9F42E1EE0
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 02:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291097; cv=none; b=k45w5thRcT4pw3mRPZFRyXOD3r1huLeF7zeTadieFvOD1LWm0cGrCe6lWn4wgA5HCfAN30znXSwSiESM+VUO2iwjxvggeMaON4tose3Ty6syz7NZ3oPhQqVoQPHb7Z5f/c+YwNA+gowRV4z4PpY+4spqE6yDP8rVaqjZkW+EPLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291097; c=relaxed/simple;
	bh=OprDKVD3dlInOK+EtkJkBGY3nlx9HocRm71U+En4ns4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZX8ebRiVISazO9MlxNb2L/6p1oOF4SnVupS59CwKc9w+442uuV4RN1P/PczYhEo6foAMxZHsW4cXtzU2yLP3YExjuGkGpRXcZve3ETOFBTQWtCvQUV8Kz2goWfI5OSm6xHoVGsDRs3/U5K8CfDdcnd+RzuoBooV9SbS3iyxsam8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=cFtqatdM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="cFtqatdM"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d71e7so943158a12.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 19:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792291094; x=1792895894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uuVxX/jLPtohDOq387cSqeqHjD2U6i5S+xDw1QtsGiQ=;
        b=cFtqatdMQKgmQSYSq39dS9PbMTjb/oOnEnOFu2GDA4z+ZyGbjIyySV5az4gfb4NtR9
         AVD/yCtLpvN0/YjkCU76bBR4Pnsj+PgIlEzafq8WYIpazHeQh6l6rsLdenVSs2FMa2ja
         5uhksrEELgmHbcewXdjdG3shuBifY6ia8hdn1DvWvYQvp3eaqb8Pck0qAPrhu7tFOfIa
         9YsX4OvnDOxe9pDGLESLlwC3Tcxur2p9YkEXHh887S3AN10uKePWr1El2P6t3TQUIJf2
         a9s+SJsSn8KYtnawo9kY5Ca0RkzAsPej6F8ZT513+kjcsYEmcE6zs2Si6xnd/tZUKuk3
         oLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792291094; x=1792895894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uuVxX/jLPtohDOq387cSqeqHjD2U6i5S+xDw1QtsGiQ=;
        b=A4idllrEKqf6SWNWtCHWb3cYYfwPFALOMxQPgnLupj0LnyP16c3l8/Q2J9HUkPDmaL
         FFBUOrPZ9cW3SXs5ChXZJ8AdYRfNnGhkK965BHaSO6R6Eq2luXwpqPXvkSQpL5MNK6O6
         gnYstR6+S0G3DSDXvfMAQ6EF9/hCVHmtphlQgzvPjeDMy8HVPFsy9ErDIMG0ZxkUDdt5
         LopazkWxe2L/9Zgig7nne/4nmC7Yj8Umj5sKRKQXBjS1Nhs2O/sBnR/bXwNpiwmXpkff
         nc4d8RYOODcPEUDDz2CY+4rV9fS9dh1ALIR2wYgPCYYygfCy8uVE41FT6Zh9MFU+DYpy
         HsAg==
X-Forwarded-Encrypted: i=1; AKwUvBz1PbgGGEj7mTA95os06dsv0w9kAVGj1YcOO5thVokwPU1oizxSLgDZD9tyvLy/dAsxL5D8qQw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlLkqZtCuiMvjUyCXbphi89Zb5adZA6Am7Ed9jrJrx4pNHDUaY
	Qkn1hcr0n21VUNg+YJg3LpARdVtHWxhRW3xpYCwgeN8IlSUDT10onTyA46FkpvjiAg==
X-Gm-Gg: AYBFou1eWlKGndYcZ6hebxcdJwnM3E6c1fL/kJVjXVcy+kSn5REZtVjDw9jUSArl4DB
	eiZd7/N+AEoKf1DUgTo/LJ2C7ilYA1RmjfarUCBwWp4+G4l8gfozptEFnNFkOFeXH0yoqdr1bq+
	r44+RQpbOVhENdws1QDwqKH02MuWjH5L6GvuOz2dB8ADN45+2Srgqcj/h1x7GJ20Qogz5jx3arN
	OAms5ENaMP7jaI3/kBx/oObwOE0FgiCWNWT3pqbqGN8/3PGVP3tdCYJfdiOnWe/mmKe7H87BXKh
	NPmzXv1/1YcXKBgoaZPT7dZrOSGKGOHs/Ig4qvMg2E6LdyR9J4B9x9M9n9gX0LlSBM0nNJFkEIP
	DUL4Do0kKwyrO7y4uIdRhog4t15UdfAP5QgKQPq7hEIjtL4DUdeQl4L9askQakdvXfgplJkh2I/
	mKjlHqIYcKBxSaMXF9WO28S1k1wjvVtbVHk0eq9PBHghCp4+GpNaqIPYP7Zukxy4LFzoV7lKqdL
	Iz2vC3BH1vCujPKUtlpgS2rfMpjUZp7ry3QKZIQ4nImE0lqPcjZfZ5eT6sisQKqw0Jif1qG2n54
	6dCRXKKCBe3Egf1omCBXb9W6UiOKdT2ZUxcIqypWFI4GSSikNO0Is7RM9IJsz+LwsuxHa59E4eJ
	4l/AOf4dZYbE7gK2CgPDeXmRPXuPSFCChPbj7/cnh/J/7K02JP+L/hecfsuu4s3UxZ9NaNi/pzz
	tVKcJHd+IvYTwUeaFoaxk=
X-Received: by 2002:a05:6402:2489:b0:6a9:850d:bb38 with SMTP id 4fb4d7f45d1cf-6b3a81766camr2392870a12.10.1792291094015;
        Sat, 17 Oct 2026 19:38:14 -0700 (PDT)
Received: from Desktop.fritz.box ([185.181.130.213])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1c80desm2356771a12.20.2026.10.17.19.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 19:38:12 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: pablo@netfilter.org
Cc: fw@strlen.de,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH nf-next v3 0/3] netfilter: flowtable: carry a priority into the offload
Date: Sun, 18 Oct 2026 04:38:04 +0200
Message-ID: <20261018023804.562323-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <atQk1d8Tv03iPN7d@chamomile>
References: <atQk1d8Tv03iPN7d@chamomile>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 18, 2026 at 03:45:57AM +0200, Pablo Neira Ayuso wrote:
> I don't understand the "one flowtable per class".

If the priority is a flowtable attribute, every flow in that flowtable
gets the same one. To give sip 1:3 and https 1:5, you need two
flowtables with the same devices. nf_tables rejects a device in two
flowtables of one table (nft_register_flowtable_net_hooks() returns
-EEXIST), so you also need two tables.

With the per-flow priority it is one flowtable and the rules that set
the priority today:

  udp dport 5060 meta priority set 1:3 flow add @ft
  tcp dport 443 meta priority set 1:5 flow add @ft

v4 waits until the fdb series is done.

Julius
