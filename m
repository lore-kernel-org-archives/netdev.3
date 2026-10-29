Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793277412;
	b=4Aif0HGpFJZP4RKNzfnXSDU4/lCwXuHgM9WPZ1UqFMg1ffZ1tD5boYF+hTVu6EEIzZPi
	 lm7HnFdwyjSY55kVXyEjTsJeGoH7qAkq754JSt7sidww9dJcBONdMIE0qKYbrDu4BTVm9
	 W2QB2/CgLhrMcnvtW+rFj9R4PKg0Vh1+GukgKLLgdu4u6R/S6KU0FUwJTqEVIjgsXEHVF
	 bP2PFj+A9m7XLMs9H9VMie/yYo0AhvUsqHHIZHhnLRklgKvJhn2peMTm9ODOrDQWcctLT
	 NKOIEdxZd07/vJC0YlsKBjqXAKW9ClFdVL8IHqFIhLGNRdNZYV90VnadGPVzQzMN8nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=hmc/RolTYy7SeBRxKLMjWzilnvA83GevNb7ysMoswG4=;
	b=PG++e56KS+ckLh/h/+hWLISmf3P/wzFcYQjC6t5yvVwC5zYKmZDevJRx7NTfbKmvunHq
	 u1vajYnJfDz6ZkXy/JWysszeUts1Vwn5mBJ893CzCztm7VSWS2D8+aLZjCRMEiXUEwcOE
	 +4TonaV0RgcyC+dVjlhrwcknDAm7aA9IVJVIJebuzsWLtKfXaSvsA8UjDR85SFkd9rMuG
	 NV3eRpEMhsADoYnhoBOmvq7184tH42FL6qk78rBLiVarukDw+wVnIwZO4dn6+wWMo354v
	 OB+PrJK7zZ3vlKwWp0p69GUNP3wk9CVPwgIKQ38wmRDB/KlEOw2nSNUB+uflyKZK5Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=py2QzJFY;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648260A260D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 12:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6648260A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=py2QzJFY
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so869663a12.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 05:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793277412; x=1793882212; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hmc/RolTYy7SeBRxKLMjWzilnvA83GevNb7ysMoswG4=;
        b=py2QzJFYgzOL03zGd3mHO2Bdili8XEZjmTBrfP3m4bXJAzbCdzUnE14wPgfXIR/hKe
         zAtdXpeTk/pgITkJricxOBeRqKkncsIhziwOUNdrF4Nqw//AZxy2uVu7JyYGMeJN48FI
         trZb0Im4c61Mqbor7x1XbyPT/JT2OH8M5BqYP2ShvyUEiWtu4h1h61NvSmb2oPk3XWUd
         KqfWHqesgeqXa/Qhksfi1BxV9idSCShFWKVwLAy8e2qHEm31JHs9zkkyVIImFi5Wd/Im
         UdHQmnMvZb/drJfythss4ld8cwQ/Q9/+VxqcJUUWbduiCALdGR9aa08Psyv3dV11sL4J
         uoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793277412; x=1793882212;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hmc/RolTYy7SeBRxKLMjWzilnvA83GevNb7ysMoswG4=;
        b=UDdr+ylocZVL/xkII7zg6CqLnGSfrxdowyrmKmAUY72P11aTecg/ZJbw/oKoOa/GmO
         8y/3GLyVLWs8ptoROL6Ew2wh+tkz3v16tKxAzmKPq7eadheIaC83Umxdb4p0slo3QE2o
         Y5+/hNchHw0pjxF+C4cQ43TCmPIAgp3VLEXv9FPHeIB3kEtavOT32PHI9Cygg4f5tULY
         dntJSJhwcNiWcdF3YS+0M/xxeFb23JRjyQYNoYl0eAhwksPY65OG3jGPIRHchrxMH5m9
         b1aA4v3JoUlpYQ6z+LYpftJNn7GmVBQOV4dS4QsrjaB6G6M8iGahaPc3wyyDrB1NvHMc
         PW/Q==
X-Gm-Message-State: AFq9FYLznIwCoP5O9OWvycO9luvEJ6tIDrIJHwTLTgLKsBk8rFJRuzWM
	TAbC8IHs6Xpsf+wgzzOFlmPeNiM/Whqi7FfVVahPKjgX23YiG7nuGVW3
X-Gm-Gg: AYBFou0nVFFW58anX3TR2U8frjeK5jFmSqca/pA0o9WEQT70TlXkgywIx8OYyVJb/sP
	eadIgsLrEoFXRP7W1DHg6I0f2hWWWijIl28o1WzT1in4TvgiEYHSvSjis019MdYShpEwT5hcZQk
	PydvhQwe+ICnHiVWcSQjR7rfbAQAn3nySZ7Jhiy//9mRU/ERPQ2fcCFblVZ5/sUSLNPCN55dW2Q
	iWeFEto38OI4vbjjsXRpB1dfINyt3AiFniV3tfAaGpKaZ6qrpJZ406eavzyiXtQw49dOFTljA13
	9d0SQx6QWokP0OY7r7b7uO3sh6x6xKl7f1tRNvppVUtjD2U5deWHUspAr6/+TMsmMCnr4q4/VZ0
	syU9V4WQaSiZEvDO28wrA9zedkcMTnpeL/DWtcQSLVV++7Z1hN4K8KGuelZn+Ul1sIZkgxv0VBN
	ZHjWpP2hA6LPjLHe1Bu+7oKL0H1/iZJc8pikssBIvvQnl9aqMbwFGi4eQKDGsIBwUbBXztfjptK
	C5Bkml7+NDUhQ9JVSS38hcW7mGxrU8xE38snEDBS2y+2T1Qh4QZI452fp0j9Oq5j+XYoFZafJod
	wMNz0ddbs8KsTqaQPsdJeIvvXGuRHBqk8DAdqcb2OMZFsG2uDQWSbpn16tQfvktEm10=
X-Received: by 2002:a05:6a21:8804:b0:3e2:97ac:274e with SMTP id adf61e73a8af0-3e9023ed955mr3933798637.65.1793277411671;
        Thu, 29 Oct 2026 05:36:51 -0700 (PDT)
Received: from smtpclient.apple (v133-18-180-162.vir.kagoya.net. [133.18.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc46482sm5225375a12.11.2026.10.29.05.36.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 05:36:51 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH net 2/2] Revert "net: advertise TCP MSS from the
 configured MTU, not the learned PMTU"
From: Esko Mobius <echoowall@gmail.com>
In-Reply-To: <20261029112045.5e7d4317@pumpkin>
Date: Thu, 29 Oct 2026 20:36:33 +0800
Cc: netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>,
 Shuah Khan <shuah@kernel.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 regressions@lists.linux.dev,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Eric Dumazet <edumazet@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <40993B2C-6390-4BC6-B4AD-967518B0CBE9@gmail.com>
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
 <20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com>
 <20261029101859.6893f1a0@pumpkin>
 <22077B76-12B0-4DD6-813E-A3968003575F@gmail.com>
 <20261029112045.5e7d4317@pumpkin>
To: David Laight <david.laight.linux@gmail.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)

On Thu, 29 Oct 2026, David Laight wrote:
> But that relies on something having gone the other way first.
> In general that won't be true.

Agreed, that is the same point Jiayuan made.

> It is almost worth implement something that retries with the shorter mtu
> to detect the PPPoE mtu blackhole at the sending end.

Linux already has this: net.ipv4.tcp_mtu_probing (RFC 4821). With it
set to 1, once the retransmission timeouts reach tcp_retries1 the
connection drops to tcp_base_mss and probes up from there. It is off
by default, and the same goes for Windows (EnablePMTUBHDetect); macOS
turns it on by default.

> Or even just use the shorter mtu for long RTT connections.

Both of these have to happen at the sending end, which in my case is
the client (it is an upload), so the server can't help. The only lever
the server has is the MSS it advertises in the SYN-ACK, and it has no
RTT sample at that point. For now the MSS is clamped on the path.

While reading this code I noticed there are no selftests for the black
hole detection or for MTU probing. I'd like to add packetdrill tests
for both once net-next reopens.

Thanks,
Yongjian
