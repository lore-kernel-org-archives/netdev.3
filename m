Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141336;
	b=JGJK0KXnzsodBUjtC6KeIp+o7SLDnTL5SojBXh75VPK74y0l6EBvlFIQgf4Uo1OoWJxq
	 RC42blErx8tJKdA5gPImrGogRFYY3S0WcKhhJI1ZqJ+EtYyRoGFMj7IcuNm1rFp+hTXuS
	 eXZGqnJJ/LC+fDGRlRegZ3+WEgLkAHDM5o5YQ7NqRUKSita0IYsWoD40txbMFegKTf9ey
	 dQNj6t/inwPKpr2Tpc8Yqbss7oz1T1Mwa+xjGcsKtOotAH8mhUgdJaSXp+DFYLRk6ayLJ
	 woQytEEcdgpvFmn9AKvng4T8Yp/TVnMfUctTjXHG9AlKtkMQ8CNmVu3+U3AX5gLKyjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PI3mxdu/F4E99n2vbtGBdOsTP2HHkJVPSsEC8stKuJQ=;
	b=sYo6bI7R7DNlaPmzCQjUyczk/O53KOtb+EXQgWc647ViDDNbaC43LUibfZnTNPD2kM4p
	 VIzs1wVlfMvJJX2s4dYXaa1n/Nc0tTHtvDb4aySIfSLh/lpWBn8WqpU+LyS4MN7mtrEdJ
	 EDfV27fyRFBO1i6yMlZYxeEf5fdbRwaH5N93+yoPg/D7UgczgHt8KFnMkwP67rDsDLOwg
	 IN5BdxAFLyTHmCcmg5k+Q+5oB63YqAQltro9JLp8zaPUhRmiWstkJfonjIMaJCKN2Ikn8
	 IKM4WpVhsiVHeDijZQeYz2PiBudSF8gAc6W7E7zT9nDa6HqeCVGrtGSIp8HZ+B4p6NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aFFtM+Q+;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B241606A320
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 12:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B241606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aFFtM+Q+
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b308fca7c3so236837b3.2
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 04:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794141335; x=1794746135; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PI3mxdu/F4E99n2vbtGBdOsTP2HHkJVPSsEC8stKuJQ=;
        b=aFFtM+Q+ywj7/wRJUg9KitjHUvOiVx7dsT2zTDfuKY4O4Y5zq2zNpffTnPQPmH1/Be
         L5Rg3GJ6lrjtXaHtRu4lfkNgFe+vQ3kOXvzMF9Apf/C1u14YTIdTForRpX30H39leAZ+
         AE4Z+A+r/K/VXavRXo4tFokWMhx8ajEhAeXkx4P8CogQBSQSuqaZmjBj39eW8Dil3x/P
         8IO30JSVlBqoXKsVn8P3jSLpGkww44H2n3T6GsJ1s21hCB9hfEcmguGJkspReTUFBWbe
         5SsEAiF5HJlIFq4UBzUK1Y7grY8kNdNlt/PHE09pQHsE1nDHLZQUpPfOqYu+1Fpa4Ze7
         RZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794141335; x=1794746135;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PI3mxdu/F4E99n2vbtGBdOsTP2HHkJVPSsEC8stKuJQ=;
        b=XSRBXDeg6FxOHpJqlv7o3peqiHL7WyDZPyVTX9eTVJdQg87PTGdHubV1aEretNM0pS
         YaptlWi8d6NN0/zDooZSsjGWED+RGZszsXMUNo19ThRyGH09A3YFIYI3ebmspsxeicQw
         zHt3wI9cW5atJ43rX4vzufh33PQrAVnAnfbvCboBkh6/yetx8lzYBj9NMpvSQCvhHgMT
         tjl7vdAwznuD4UxRVvNOgU7JE4TD3zoOP3r8cbNuTuWs0TI3WdeuYtusIPL03so2OFUE
         8tS12I+fiC7aZf/cWtFypElwrwfIlrNiwRKKrcCm+oY3rUWoEyd5A5eBVNfoSA5f98Et
         0grw==
X-Gm-Message-State: APuU4Z/dKS8yN7qcjxRIgSuH8O3UOiz8kL3cShZ7KaTY1AXpMudrXiff
	T3gBKpwLVMy8yWff+zyr2upzYRdzvd7vDTwnbEyIPzgmMTYdaPWvN0EFxG7fZ2KL
X-Gm-Gg: AYBFou1kYrPOv+98kzV3F8w04taVW4fypr2OhLfOvE07EVDmUyj+D7TySnT6yhZH1Eq
	4p32wUH2iqW02JfkHI2cMRfo2vnJhiMWeGSxii2K/7CoPH18HWQqEP0tZa3FqVOruxWsQMtI1sk
	IcnYVN0ItDIEcx/blpUFwpfsVDIN3DrE1nchwI2rF3fQopIL7+kb7cXTbQi09N2ZaiSot0I2qs0
	x8BYxCf7w0ihetc2V88V1L2gh09l97E4CxmwZ7hWY5cEFPsOLhR3T3fdzE1Gi9fkbxug3wg94Dr
	4OeSy+cLhBUKnQdtwqOgKP3rml+fuegtLyEDixbSLxrWT/bXyFjeP6hJ9YmWuJeV0ogGl6DgcWv
	bniKPcfIjoKruQMWRth3UrYK1t7tzJUF615XYmgxWrerQ1+KYdNvn79EsuZxvWG2Korb9k/y+ae
	oZARPG/9uzOzjom4JbtoAND9ZpUqsOZ165PVWJLGFqDHXVxctkrVwhPwIoXB3ud3UFx/7oNzNaN
	U6zcyU5bZkcOaBpjBNpYZwhiCHwZsQX5PKN2W1svsRKohfN2uKckN8iJx/QkQ3Nb0Foxjl0+KH8
	goUYi4dCYEcnquI48SN9YqxDqToFWAaNKovVlRDBH4KS2PXrpCpzQY0F
X-Received: by 2002:a05:690e:140f:b0:67c:1e0d:f7b3 with SMTP id 956f58d0204a3-67c3d7afb18mr892949d50.11.1794141334626;
        Sun, 08 Nov 2026 04:35:34 -0800 (PST)
Received: from [192.168.100.12] ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c3b959615sm1680270d50.14.2026.11.08.04.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 04:35:33 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: netdev-bot+sashiko@kernel.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Paul Blakey <paulb@nvidia.com>,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v1 1/2] net: openvswitch: do not record user features
 when the change fails
Date: Sun, 08 Nov 2026 07:35:26 -0500
Message-ID: <179414132635.2826493.1662034784357588334@gmail.com>
In-Reply-To: <20261107113403.797779-2-houminxi@gmail.com>
References: <20261107113403.797779-1-houminxi@gmail.com>
 <20261107113403.797779-2-houminxi@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Both points are right, and v2 changes the description.

The Medium one is a wording defect. "A failed request" reads as covering
every request that fails, and the paths you list do still leave the key
away from the features: the NEW unwind after new_vport() fails, and
ovs_dp_reset_user_features() on the -EEXIST branch. They predate this
change and stay out of it, as the changelog says, but the closing
sentence promised more than ovs_dp_change() can deliver. v2 says "A
failed OVS_DP_CMD_SET then leaves both the features and the key alone",
and adds that a failed OVS_DP_CMD_NEW and the reset that follows it still
leave the key one enable ahead.

For the Low one, v2 names the reachability and the effect. The request
needs only CAP_NET_ADMIN, which a user namespace that owns a network
namespace carries. datapath_policy has no entry for
OVS_DP_ATTR_PER_CPU_PIDS and the operation skips strict validation, so an
empty attribute reaches the check that fails. A disable on a count of
zero reaches the WARN_ON_ONCE in static_key_dec_not_one(), which panics a
host that runs with panic_on_warn.

pw-bot: cr
