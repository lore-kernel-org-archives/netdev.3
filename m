Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E352E31F98E
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 03:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785726242; cv=none; b=VkSM4CAtyFNGNTT8MLjZ4244SW3//xsZ5+KzA71eDbg/FeMN86ZQyfxb+pqBj5hxGgz5h4p5fMN8w/relr2CqmjJaxXzdQBJ1bB+tJDynvL3Fi2Of8zY46mhm9ZMQheH7IuelHVcqV3JmDGZD1Wn1xAEUiP2BJ0G1j7ZbdUz7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785726242; c=relaxed/simple;
	bh=dGItCc+au+pcL/D+6ERcN1tXZbKZDv2Dm1oT9YquwuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M5Lch2ERrB3/nX1r+7R06ibgMLaS/t5puWYaGXWQ68KIga+50+UMzZXsi9Xo4D9tzpkxjBxsaBQfeAzg8UlP4k70d6kYcE52sonoZxodom/bSHEiwbGtLgZSzcrWWT5Or1b1O7eCQnzHu3IacCKNyrr7pMC8h/RLxYaG/rGC1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7AuC8UZ; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7AuC8UZ"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6aaf2f9ce3dso1275885eaf.1
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 20:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785726240; x=1786331040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xs3tFfBdwPHn5kHrb6XAfXxDle7pqRmPk1hmRTFHJR4=;
        b=c7AuC8UZjARyiCduO879r/3ElbUDm4O14wCfSWe3xEPDnWf0hSyoAsFYniNBzeBe6d
         ZcuFWNkg1bmokd9P35ofh3u2bWRkicjtKSYtx5r8E3bKB6Hm51hlfx7gipx0SyOLouDC
         YQcVBuGe7RxczDLEOWVz5EQxonicB8CL2HKoCRhN/n/CghovKR2aAjc7bRwWB2XdaTzQ
         JeaagDUxW0NMh7XpHsJaKu9IktM2/Ae8WDn3S3XDBC0qvxC2s+bLuZfTf3notGx2ZRB+
         ekTBnXxrvxnAnteNM7QsW5jVva3mCi5GJ0Gi1D/A0BLyANEYGtLsAiIjOG08EDZ4SWnF
         KAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785726240; x=1786331040;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xs3tFfBdwPHn5kHrb6XAfXxDle7pqRmPk1hmRTFHJR4=;
        b=WRu3MbZv8tqh3xPyeKfEy6UN2u7OIHgt/4Q8ZNeStu+DiCdqYB9vsGI+d44qlnwk3Z
         ugFCfizBEkRBJgHngI2grnHjHWhHplngmrOmfIV8GLK42MYzBmdvVa76adAvSrrmrJ81
         vaPST5TC+52GcAY7E/+HFY/RMNif5DCnDR1zr3JOx0bdWmgsqnVOM9E0zIPOw1tK66mB
         zQ0kyrqaUdRdiV3E1v5/OT3V0cpjOiEEQHypjVb24jNHfSZ3+wCZk9lCzcrwNpE2LwWq
         tKqJ55h62SgjGrQhpy1Q3mcxGbrQ3lBQrT9DuV1MGVnOyDagXbXE7RP2D+1XClMimMo2
         Bqjw==
X-Gm-Message-State: AOJu0YxKPS3U3H5tFLweE8AbaGQjlpQUWjT6hrbrCmgLFoI85ofd4kLO
	aBK6SuDEvt84a4mrdj7SPcm+G82aP6LJNVCRKYW6MqwMfI4duf+lWO7sI23B5XmDG9g=
X-Gm-Gg: AR+sD12Fm9kB5JtK0jS2mv5dYFtYfMxfrTVZAh1Kj85QUOW6N9gcsCfSJuPRN+t1Cgm
	S/i+adi9fOyirHzmHI4avtXgmNwlGg2OId5Vd8FtdUsVp4BI0q+R7y2JZap4DQRjCQa3Ce4M9r4
	swO77TNdQVQnFU0KlJIV2NlZLJwpvrdn/0ANTccS0xW7eNhyWfuHqCyKhW2wK1QmC8EnQbgtd8i
	4RwIuOerIPdyzYrARCmWbqYy3P6MrtLpj5G2jvVbbl3HYLGkQR2QGAnkFKa08L9fAr2lXZh87y9
	FNMIPyvFaEVlUDvQ5MzPm1UqhPdpyYaadY1KtGLwSbhbo3+dz0W2Gc8nT7bx5LqL4JBtuvuokOn
	mMJvHGgn59NdiMeAz/6KMe/k04CVp+zcJwqjXjqDFgr9Tc3wUtgqVeBqa+/y+Xrzz/lhgXvTpbo
	tXa93DH4xbgLH1TQbI7GR9nPpHXSDdqBqTsaEmAkch4XHWHwYfJ6Mn
X-Received: by 2002:a05:6820:222a:b0:6a1:80a7:2c8d with SMTP id 006d021491bc7-6ae433c50ecmr12236926eaf.32.1785726239666;
        Sun, 02 Aug 2026 20:03:59 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-458f60650c2sm7883058fac.2.2026.08.02.20.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 20:03:58 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8] selftests/net/openvswitch: add SCTP flow key support and test
Date: Sun,  2 Aug 2026 23:03:50 -0400
Message-ID: <20260803030350.56455-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <f7tzez4v7vg.fsf@redhat.com>
References: <20260731062655.4088575-1-houminxi@gmail.com> <f7tzez4v7vg.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Agreed.  v9 uses a single

  socat -u SCTP4-LISTEN:4443,fork STDOUT

for the whole test, so the flow rules are the only thing that changes
between the three phases.  Both respawn blocks go away.

> BUT, as sashiko points out, we do this multiple times, and don't even
> check whether the listen socket successfully comes up in the second /
> third ones.

The check is there -- each respawn is followed by

  ovs_wait sctp_eps_has server 4443

For reference, the sashiko run on v8 reports no open concerns; the
listener restart and that wait both appear under dismissed concerns.

What is fair to say is that the check is weaker than it looks.
sctp_eps_has matches on the local port alone, so across a restart it
can assert only that some listener holds 4443, not that it is the new
one.  With a single forking listener that question does not arise,
which is a better reason to make the change than the line count.

> Sashiko seems to imply that we could also do the wait-test with longer
> timeout, in the case that we respawn the listener.

Not needed either way.  Two of those dismissed concerns are about the
restart itself, so dropping it removes the code they were about rather
than widening a window around it.

> https://netdev-ctrl.bots.linux.dev/logs/build/1137903/14722442/check_selftest/

That failure is unrelated to the listener.  The selftest config check
strips underscores before comparing keys, so CONFIG_IP_SCTP has to
sort before CONFIG_IPV6 even though a plain sort puts it after.
Fixed in v9, and validate_config_format.py is clean on the new file.

Thanks for the review.
