Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517134B44BE
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859138; cv=none; b=b7xYdsmtD6zxfkB/4m8gdlW1McvyUHOuB8JQGbeYuiBOfui6reRvBu5Rc4946SUOpNnxdfCbRxjnD7POs3aklMPYilef4b553xlEQCoRrBSCfQIrMGsYz+9m3Ct2Iid+/9KY3/hIHImkqN+LjrG4SBlgZxm1tA5QbzxNHSJB2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859138; c=relaxed/simple;
	bh=dogMI81wefaNA3bJRQNmeNrah8qHK6X0hHk71xmIfEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XF/HLsX5kBG/bLf84iXS2ERC78yGC45vBoz5+KErQjSpF/O7Gf06avSISsR0VSjUBWGleLgr0sEip7/CgX7+RU4q/XXl0nMPiRqVPMdIDmOj8O1hN/6ty3/6FXNg7l0NATsg2N5GMdA9RsNXgxOMjhJ+b3DnqjviGNQBaF2ASc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=Hsoku8Pq; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="Hsoku8Pq"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ff9642c57so13802505e9.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 05:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1790859134; x=1791463934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dogMI81wefaNA3bJRQNmeNrah8qHK6X0hHk71xmIfEY=;
        b=Hsoku8PqtIw8yW8s8VVkgJ6aS867WLqFHHJNtTyOXJ1I5o00YXSG0nSgYo1eDbDKnA
         Z1R/DkIrzHbHTu0njbtnYCUM5WEemLOL3EzOvbSoqVwoF/IWjsBEh7P8NjV9YHh41KoZ
         UsoDocabzKqnyEeUak6gZ3h/+tUJ8mjpQV/L7wMWe0dAlg3NKxec3UwkkMGil4yFom0w
         WWo5I5nbnd8pUXf7mRqxbtR+LExyrRUpCPOTa8qurwOjj7avs19BZzqVfSeeZWxD/LSw
         6EoyKUYFLQIucCeh7jJFGV6iRbb4GCA5d4DbhgtkgODlRp/fNdmdARgcWMsAxU/bg3hG
         xU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859134; x=1791463934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dogMI81wefaNA3bJRQNmeNrah8qHK6X0hHk71xmIfEY=;
        b=TLIMOVK8E6/mQ/WHChnX1Gei3Y7za48qFsHGLYCZCSElNXl4sOeOrkXiwvXS8UadK6
         9NZ80lJFuHdKDa+cCC01UHuk+u9+c6ESbx+OzlspFs6j/oJgIo0TlpdoqQndEoG0ZYC6
         uyvIJV4QoOOczEFFDx8/u1sM/PPAUg1f1Qdr9z6hPG2GMPc8KATg+xenKa+Fqr3izIkQ
         zpa8tOBik56W/2xyKgAkl6ZPIjrt4S/vik1ppX/YI2khVYe9p4lDJ+BtDAcvHYKtlj+I
         ktFGeJAqycUUgEpToA3bUf528hXU9TYUduasBJJlNOrD8rzgK89hn7peeyVM0+VXgFU+
         FYcA==
X-Forwarded-Encrypted: i=1; AKwUvByaJOYe9d3g16IlKU/FV7HNmJNVRjUaqDyLM+oyImhZzqIgyOhH9+9f4nWBVU9+mPXhWH1TLGg=@vger.kernel.org
X-Gm-Message-State: AFuF++nPndG/gyN/jUvCO/HtJOcXpIVA0BwWX+Irlu9YhO+36ypUMZ7C
	MsQsJ62kLuMDe6lP2m2foQDbZI+8dDtyTNGoot5sX+bpGIuzfsWGNRAairMuGV4zBVs=
X-Gm-Gg: AYBFou1s4268CChk5K1apDbU/eEYbyeBn6WcDrz79/Iotq23s0yYjGkgMHLJb54TNeI
	7mhb5JdPrZLkBZcqPFuBrgMFvHSq+D8jkMFcPZ9Emf7usJRG5PiHenNX4ixL2ZTVAzVyChz1sCY
	l0kRWnLhkcRDGFJk90NrlFHuiJu1byWhKiM0LRxX1ZddQ7v8Hvr2ZuHRzmoR+3Nz3eKlg1VUKqY
	4Rnya71a30gPXasPpsI3mKmbnP13vsg1GOxq5lLoKYlklLR1QWNfUQmPFj3zZXLqhIDHFvpYHLK
	kp0JEjbydPtQKUzd42FeMQOxzvHAQrFhpptVHsD5EZq7izEgWYz22S2M6IsTqMtNAfJ1/jdhfI7
	WmWZVezeZK9Z9X99ouAfhqUZW0DndUCSrZ9r17qrwGr5HdsyecJsnZG9YHkdgwKa+fvbYYOopcZ
	7CHsUM7wFBNwarvfobA4XPMXPcwag0F0VK9TM8Ev0VS8ZZBWWqRB90NAy2KI/ft/sTapmt+s352
	sVF+d7FE/rytEn3pfQ4jHGRQ10nRRPaptDdYX2chsZsDpPsbtXxaaKZU1FQyPcX5FMsK3pkqcSC
	ZMmD
X-Received: by 2002:a05:600c:474c:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4a020b4bd9emr35767235e9.16.1790859134102;
        Thu, 01 Oct 2026 05:52:14 -0700 (PDT)
Received: from localhost.localdomain ([197.51.130.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f949709sm100008005e9.12.2026.10.01.05.52.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Oct 2026 05:52:13 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev-bot+sinfo@kernel.org,
	Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] amt: pull the AMT header behind the transport header in amt_parse_type()
Date: Thu,  1 Oct 2026 15:51:54 +0300
Message-ID: <20261001125208.27182-1-omar@blockcast.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <21ba1323-7619-4721-bd1f-9ccbae42761e@redhat.com>
References: <20260928181557.85796-1-omar@blockcast.net> <179061960357.31693.937915571809434718@kernel.org> <20260930222733.47563-1-omar@blockcast.net> <21ba1323-7619-4721-bd1f-9ccbae42761e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 1, 2026, Paolo Abeni wrote:
> Due to all the above, plus 'broken since the beginning' and Linus
> asking only for critical fixes at this point of the cycle, I'm diverting
> this one to net-next.

Thanks, Paolo, net-next is fine.

For the record, since the commit message overstates it: from reading
the code again (not reproduced), the byte read behind the quoted UDP
header stays inside the skb's head allocation, so KASAN would not
report it. The effect is a misparsed type: amt_err_lookup() counts the
error in rx_dropped instead of resending its Request at once, or
resends one it did not need to.

My reply to Eric promising a v2 with an Assisted-by: tag went to him
only, by mistake; with the patch applied there will be no v2.
