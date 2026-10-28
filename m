Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158725;
	b=0dq4C6S5AFAl0FKAeLrohUDo8X6Zf4cdpBz4lq3CLImu5ar0M4Pjd9jLXgzX83dR/T44
	 Gb5Jc168xe/AJ9Q5vZfsicF4F4Xmrdl1LR5JEbHb5Ydg4mBOKF0rIdOWSVDyU8fnb7ga1
	 QJwGVr3SyEC4uly5gwOG6C9Zr5+X51aeDk6Fnxxz9kCQMc+kuJL6qWSLcDdspb7sgHhIs
	 YwxS/oBjZiW3ytGZu0093HeKIrdtRiddQwoUZv5rcf5UgFNtHW5uBykFgFFB5UIIFq1CX
	 gxGVAYAXGDu0Hs8eCsLZKMa/3DidsDdpDBGULlVKGF0+eYCwM0kmyI/xTyQhgj17lEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=VQJFWsO2O0YbolYW05VDBIkhficw7DwnVaUUdw0UKuM=;
	b=Cv/50gbPz5Rnj2XQlXcOpSzhrCPKch+WSSzCRVYc1SMfzVCTpFMUhdfsvx9s+YviR/rr
	 YeH+IPgHLJeyHJbwIyI8aGf8D4RAQDCO90qj2/ve/k+BTRi+6yCpnXtXnAcZhC0E1ajyO
	 0iU42MwgaOP+Tc4I20FUAz1+W0ywgv4Uaz9uKMX3JtOwG3hiZbHD5S2zpEqSfyz5USlry
	 G4e6baFDTDGpIiP6aXhxTjqyGEu/HaYaSknnhkGNCtQ3bdjHY+9cqS1iq09KNk2/PQRJT
	 UOdgsWaDH81Ps5CDy2NahjWPm4h2b20LPDiT0YAeaETIMXZZ3l6tfmsxs0KoOpKjROw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kpXTMhRh;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82CA606A320
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 03:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A82CA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kpXTMhRh
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ea1e7fad99so2776925ad.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 20:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158724; x=1793763524; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VQJFWsO2O0YbolYW05VDBIkhficw7DwnVaUUdw0UKuM=;
        b=kpXTMhRhTD0FmK0+Tjl0Em4BWm/lyKJb+frQFOxvez1rlXCx39Mwq++SjA21V0vDEx
         Rsgjc2ofwsAUcM8LYToGox3wv4FFBgo4U5UmA8c73iXaHbkcn05wIsJnE7Nxab5aZQVr
         OBIFEe8rYgqsKEQXvfygKrbJh9S04b1Si1sAadYfYJVEevNDvex+hiYBwSlu6nqWCyaA
         BS5iHOlxoj5z9reaALRU1FXhS17w4BQWqYd4U+6425KuO+rThn4nNkiuERSOFJrnoGLt
         X9WYqaXBlHChn6/K5DMWMT+yz1xqsXP2zwE3pCaptODUD4DUcJ8S7r5ixJXN/gVpXvhF
         Bu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158724; x=1793763524;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQJFWsO2O0YbolYW05VDBIkhficw7DwnVaUUdw0UKuM=;
        b=mOphZKPU00COTMaAtlezedH7ju3W0BQAOXM98pZ5dN6Rs4HYodr3GJFbTaHe7tJQr9
         9RG9C62uQeOHs6X0ltnp6HByY242ja4FTMD/j4sFf/ZDAokDy+Vb51U4PY1X9zJ7YY0l
         1Xa2ic8gGOYA1cC5L5itSsaBSHvf6ZFvrssgC6PxH16CPN3VvPLlT1YeO7m4lT7FkO5B
         RtUbGoe2XpHeOErSacu53Epz5mEGjDCBjCmlsSoEUpjONweKcV01N4l3pJYxetZOdc63
         5MQDRjb+MD9DSddCvLfDyl2Xa5VRbjlzRs5esRor9BKxCc23rGkM7x1ZXTghVYRzT/2x
         8HgA==
X-Gm-Message-State: AFq9FYIYMnot/pterSbWFCqIcfRb1iL8aJDrZJCJmPpb9kXIUlA7xzFv
	nAAekW+8EhHHg6aFEgvxBSVPSTgbkTu1xpnwbx34RmocLB1rHWqBxYUt
X-Gm-Gg: AYBFou0DlfAxEJ/H2irjxvTkPP8db1gHspC3Ci4qDbb1RNG2d5OOev87gj2Tsevvzl7
	7+snuGf56MfF76fqC0mKr22pYXObqfRfxgeYYCwt8PAM1UBgSVNcL1KiPYMzYqg7LYYcegseqGH
	TN77GTXYtWE8zIrpeJTIqG7NRZZ+2J4VXv8OfdqIwCmUGgfI8ouIrT0JnVuWzP4z8qSj96q4ELV
	luVNoolk5nhTMKZbtfmUUlOOvbY2OrxIDI56bwKYL7n11D6kBEnx5Sqmsz1Jm7vr4XzBKzdtHVF
	3hWkXtrLjyX5PgYPh7/QrQ6OlYndM/t1ezl//hAcDGzUVypRKIwDpyQnBuPRU5pJgvkXszXQmQJ
	HTwGC5NhYI3tPZPyOOwIPCnMPJX2J3vFx6AW0vCgG4l5+gbH4WhEaCODYxCdCSPPBAcidiwgBQH
	/284tm7ZPvYe3MFk4pJ8xpCYpqE00uI/p/Z6odKXVBjCzBaGGs++apC7imiftA+YjXJQcbgHKkX
	D01Fgevp73nqOJevm5G1XTXnZnGdZii3Ly2bg8eQ5sADOLdyFUxnZO8emks4omtWvJh2XXE5T6j
	v1dBqeKbxq/Q281sE8SjxWJcwPKhx9BAR6rHO2eNDGJmOqrMI7vWN0rxeoG8wLQEKr0=
X-Received: by 2002:a17:902:c40e:b0:2e9:8202:5083 with SMTP id d9443c01a7336-2eb0051eb1emr13234255ad.55.1793158723876;
        Tue, 27 Oct 2026 20:38:43 -0700 (PDT)
Received: from smtpclient.apple (v133-18-180-162.vir.kagoya.net. [133.18.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bdde77sm15882685ad.31.2026.10.27.20.38.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 20:38:43 -0700 (PDT)
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
In-Reply-To: <20261027161813.3092f32c@kernel.org>
Date: Wed, 28 Oct 2026 11:38:24 +0800
Cc: netdev@vger.kernel.org,
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
Message-Id: <D0F0DCA1-9CAB-4BB3-92CF-223C9ECA9BF5@gmail.com>
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
 <20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com>
 <20261027161813.3092f32c@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)

On Wed, 28 Oct 2026, Jakub Kicinski wrote:
> Is this your real name? We need a real names for code contributions.

Sorry, it is not. My real name is Yongjian Wang. If you can fix it up
when applying, please use this identity as the author and sign-off on
both patches (and in the Reported-by of patch 2):

Signed-off-by: Yongjian Wang <echoowall@gmail.com>

Otherwise I am happy to resend a v2 with the corrected identity.

Thanks,
Yongjian

