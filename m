Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434493;
	b=glvTRIZfaOq/g/5QWGHJMV9Y5XZCQBjfvAhaokFaS7RUIGbUOhKv4iM8sBGh22xRXegX
	 E4GL2MdE9sVBHoKAcalutFOc+AAqMc1508kq/3GjmhhZOOguTsZmS6HJaQC4S4q8fU4xQ
	 hXAPqkl6yCh/f0iARDtB8bxZ9MNDkYVfmc8cGR6bYGqAniU2BsUdqVNw2nTpp2W3HMRDf
	 BV87prRFxum+gxO+o5XB7tB77B9vbCmCgMdfWqvIRvfk0+cNSfZLXDzlswK1lg16SZuRZ
	 nfEDuT1hApoN57C87GQBOL3g1iv//zF+I94QfUhBH06jmXUqYP+p8qEYKlwtwkz6XtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=al3+UYGejhM2clXNJw1k1TrZPOssla3woPAY3sl2LlI=;
	b=jEZr19n9shD5yFuPe148QlVecImvJ6MSpOB5UEcXJbJpRrEd6NdxK6D6hmd8fklACDD1
	 G6eWlEvCqFGyneR4keMVrNsh1sGKY27qkgX/fq/fM+JZq4AaXwQQsUzzg7zvtkQ6ptYUT
	 MUerCJZps50K4vp8CEt5c6mYE3bx0WycTGO9DIj2ExCBHxsk5q0BiiDoo6lCiJwz2aXsg
	 oDR4KafRcm/rsSCoJVZbhYEY0jMU1xtlPrPyMq8WLdQ3OCRR/1FFh8MGxeQWACTyXS6n+
	 vOimDPiA3x0x5vtMkvHpY7v1ySbSlsoCOIoTzeP3+CNYHXyTV5kBgn4ngwYKwxgFz9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FvCf6kmj;
	arc=none smtp.remote-ip=209.85.221.176
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3617606A891
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3617606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FvCf6kmj
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5ee27c9eec0so68913e0c.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794434491; x=1795039291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=al3+UYGejhM2clXNJw1k1TrZPOssla3woPAY3sl2LlI=;
        b=FvCf6kmjezTgywV1J/MpmyaJ0lph3+ifxVPpAHHYyNcJkY9STu+SFeQwZPFlVBwSFV
         9LR5av1bk5YMGmg23GGES6gyyBAbf8LZIkAdaUsYycg8aP+6zXi8cZXOZo1sA4R6VoMB
         jqFOmfqO5ZxFb9UAy5fP+z+EBepFtJytpKBYPZxuoAl25Ln6ZlTpFYI1ug8O9/4FiKcw
         J9iKnJfJnfnTG4jNRLNR1Ic8hyfOSbhITcA+6QogW5QsXvu6wQsAEk9D5wvskyfJMyE3
         DTFqIAuyJRYcpIZOa9fwWo1ZcSRGPNmNgVIIScDXV11YoSTU0P74v7OUuIGfDbgO0L0x
         1Vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794434491; x=1795039291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=al3+UYGejhM2clXNJw1k1TrZPOssla3woPAY3sl2LlI=;
        b=pX9HokLhzVfAfwGfeN6Sp1/mV6IEqyLc62aWJGc65oPY9BMryxuOgHnJm5f3pD8NWI
         f0xICg5NktJSGyEPamyJz80BU4l4E1XUfIxZeaufHToc1YWND9RCCZXMyTLkd0AIZFJ1
         7j493zJVClAZs8eH/bfnLmLnDu8PqmvzV+IZBQt65fGPQqRMkD/th+TRMhKB0iDkXrEM
         qb2PRrkiJ9YqZ+6gaFWoxo5QM1uTCXYnR59dIYBk4R1ncQAOA7UbNbqXOZoLa841jgKV
         fCcL0o293NASBqHfY/bJGzsmqC1mXpt2cr5OQ4WuA3+zOf8r9jB5/+ueC8hnOmVVnT5N
         WyJA==
X-Gm-Message-State: APuU4Z8gGThUFLMv35cjjyKPnEG4XsXi/5hgikDN671TY6+wyBEKFQ6x
	eIIwzSWU+oSkt+9Iltd3VqJGSyungxEa7H3YwVGZaR7IzGVU+sOmMguIJNLkBth3msrA
X-Gm-Gg: AYBFou39doI9SIsTsnTEDpa+DVfA/2Ey2If5Jpt3SSzS5H5sOp0cBzuep2iqpYMKUdq
	YMXarz9KYTHtyRorhEaUwcC/utLz7rciyAc7fhUc2AaHKjm1Q5WR5s2kOddzOCVBEKrtFNagXT2
	5+X4s+R4niIZybL7PoTQA3XRDLgMmP0C4lUpfUO9RrlLa2QfvRVIGXJC1BJH0l3rwO/eHMRb9la
	Sbzi6p+JuhN7Ll9xU/TkuymrlPr2OqZUrEqxBWC4UFflSCfEnt2nQHvx30dElfSySQ6v69/vLUr
	lCwz5ld3MJfST14XD0mRuQrzrlvwS8eONkOgpEVAX2I80wt0UNeJafbv4qRGYa0QPAAh/qo74n7
	5LGPsHvsDB1Ah1TtaZWnFs0Hep9gfmd2s4wBwLXh0H8NuKFZPYkOSQtIBTN+DkRhlmmewefwIaF
	Q7KwaNKq+m77UKnk9w451XvN1tJ6JRsee6cLaQupMWp7pnPkpYKWSm8XpUxIJf2Cjtq48xDpHvG
	v+fPuRpDlQc7HlFm0YC5o8L9VrsZg9Y6upf/Oa1DYhjMdFzy20mi6U4o73rBTn4to56UI8uA6b8
	fiIwj2uNco5+iHob3s5MVCw8e2On
X-Received: by 2002:a05:6122:130f:b0:5ea:c6c1:8dd4 with SMTP id 71dfb90a1353d-5ee1c3e700dmr1467380e0c.5.1794434491451;
        Wed, 11 Nov 2026 14:01:31 -0800 (PST)
Received: from Ixchel.lan ([70.49.63.180])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c1fffe63asm4557992241.4.2026.11.11.14.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:01:31 -0800 (PST)
From: Vlad Banea <montrealtango@gmail.com>
To: netdev@vger.kernel.org
Cc: hkallweit1@gmail.com,
	javen_xu@realsil.com.cn,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 0/5] r8169: RSS for the RTL8125B
Date: Wed, 11 Nov 2026 17:01:09 -0500
Message-ID: <20261111220114.3863505-1-montrealtango@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Enable RSS on the RTL8125B (RTL_GIGA_MAC_VER_63) using the vector-map
interrupt model and multi-queue support added for the RTL8127A.

Patch 1 fixes a race in the vector-map TX path: the TX interrupt can
arrive before the descriptor write-back is visible, so the end of a
burst stays unreaped until BQL stops the queue and the watchdog fires.
The fix copies Realtek's driver: read a register and look at the
descriptor again. I don't know whether the register read is needed or a
short delay would do; I followed the vendor. The vendor driver does the
same on the RX path, but I could not reproduce a stranded RX descriptor,
so I left RX out.

I found the race on the RTL8125B with this series and have no RTL8127A
to test. Javen, is the RTL8127A affected? If so, I will send patch 1 to
net separately.

Patches 2-3 make the vector layout, the RSS hash types and the RX
descriptor type per chip, with no functional change. Patch 4 adds the
32-byte "type 3" RX descriptor that the RTL8125B needs for RSS. Patch 5
enables four RSS queues on the RTL8125B.

Thanks to Javen Xu for confirming the RTL8125B's vector layout and
descriptor requirements.

Tested with two RTL8125B on x86_64 (KVM, VFIO passthrough) and RISC-V
(SpacemiT K1): traffic spreads over four RX queues and link changes
arrive on vector 21; x86_64 runs at line rate both ways. Confirmed that
without patch 1, we get TX timeouts with bursty TCP traffic, and no
timeouts with the patch.

Open question: the RTL8125B can stop receiving when its RX ring runs
dry, until RxOverflow is cleared in IntrStatus ("r8169: enable the
RxOverflow interrupt again"). The vector-map handler never touches
IntrStatus. I could not run the ring dry in testing; does this mode need
the same handling?

Vlad Banea (5):
  r8169: recheck the TX descriptor after a vector-map interrupt
  r8169: describe the vector-map interrupt layout per chip
  r8169: make the RSS hash types and descriptor type per chip
  r8169: add the type 3 RX descriptor
  r8169: enable RSS on the RTL8125B

 drivers/net/ethernet/realtek/r8169_main.c | 309 +++++++++++++++++-----
 1 file changed, 241 insertions(+), 68 deletions(-)


base-commit: 368fbf5d82da9ebce309449c74fc0b128f7d0219
-- 
2.53.0

