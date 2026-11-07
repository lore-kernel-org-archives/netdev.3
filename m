Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794044807;
	b=T2u++l9ddfBPUG13FjixIVgO1/PAE5xOog1uEwJyJ3GqiGhjCSU4oxj/57ToNKprc72l
	 MDSKqNSEH+Q9H2cZVxl78udXZ2Y8ZBVAeG+r7crLFgimHwnWKJJ6mizhVbW6alEAKUDo/
	 kjTVf9zH/9DdKz/lhTbrWajKIiDZwVj7dcZx1nQk2O6lfkvBJcJ8IzVuWm1CHT1bm1LPZ
	 PXOgWbGBbrRHHPtgtwkK70LbqI+K7YMtyIt+6W9kBEapyUF/oRjhy7tG54DyCA4YIpea2
	 +r8JTRg2RHO4+sgBLbLIleYDCakVqkhw6E4u/wksF8P0mu+lSUIE3BLUVLzgI0gy9+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794044807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:From:To:Cc:
	 Subject:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=AcKtBQkNyQn8m4NmLz6hreUobiXaoInBfOtLRGrYNvo=;
	b=sELavn9GSk8Yg8sW0bR96y9CfnNAwJ9VneXakjinI/Z5mybupfH+dTAkYjPg2ggidO/B
	 91pJ8eUuzpeMbX0IMNWSFlNl/GneUUaBJFC1H0wN7oRcZVOIO5J2hJrTEbLnpUpBar54b
	 RCyraVh24KV3nOnPkOs7I2odCEJxn7VQFYO5wM4QjZI6xZpDTjeQAzYSTSYgvJQnFOMEe
	 x7FFFpcRfJxCUGm/qvvypPH6gt8hYR2MlN7tcQMLqqWi7k8xSAVwiOuIZKRMKXd1OqUP/
	 0fLsZwj3c1fgwYDd2UiFi2ipD/h8Kc3kyiivkUQln1Gd1hU1ByFg+EU9ANEbkx39uew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ny7sw3Za;
	arc=none smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E65606A32D
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 09:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3E65606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ny7sw3Za
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67990a45e02so1527199d50.3
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 01:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794044806; x=1794649606; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:date:subject:cc:to:from:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AcKtBQkNyQn8m4NmLz6hreUobiXaoInBfOtLRGrYNvo=;
        b=ny7sw3ZaMWH8uB8lOe2QwduaPsOslQophG7FsSI3vQijCdlgiO/9ANBukv5zdzz66/
         wBK5qAnYIDGyfRnmw2vlt0qWG0XWnehoEd1jmu/pKxv8LWugppnlsvp6bQG/Dt+ogOcN
         XTT9d7+WE2Qy1phXbG+/6mFNuCQrDXR0/7QlDF2Bh2u214LCXlBDpumsWBRDyrhLreWj
         bBFL6uniqF8nMCoODAk2K5FADtCrOPj+pwYosQX9e5z9q7W9lhlV5cjyTs+2ovxA0SlU
         lFrH9VbDC2I8t9BNWnqmJVyyWkW4uXeKYX1R8IQevF/bnJw9oUB9saDVS7kVeNyL9S83
         hvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794044806; x=1794649606;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:date:subject:cc:to:from:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AcKtBQkNyQn8m4NmLz6hreUobiXaoInBfOtLRGrYNvo=;
        b=kfFVNL9QidFf0QzsquoqyxqU898nx8kT5sMpvO4cudBCeXCk8t9vrIBhtKFvlJZCJl
         hJWBDCkPf071rAKoeQcOGAGUxh5C/hnuEJFMAhayluqIOe3Iu54uSMpB4IwpVNPQXPbI
         xGjHqJkbIME/4rqKBjN64+jbHjouEz86LxjffrpefZ5lWDxzZKCoC8wcMSj64DgM4jMa
         3U0xHxR9uTzpAojHYg1DT55lmB77LioQIYvL7NtGr/Olvu8oUt3lbP+7tufxWN+4qEwl
         xcB4mcApC5FDCtzhxcKAEXdRQneKSfFsHk88G4NFm4U5xJC8aL/JlM9zJU1Ho/bxAwD/
         BiXQ==
X-Gm-Message-State: APuU4Z+kwYWkD4VNE5cuRrCmpcGLzKx1potqGBReK8FMj+rpvspgpDZG
	XYemJC2zjalfCsQqmKIOz59/vSfXW7GWrHbDcVmZ6PMtntTyisizHyBOm6DoT2Jd
X-Gm-Gg: AYBFou2HgOK/1pVW5RygpyBmN3+CQNP2B01kXlshVFbsywy0fPIBW5fk1vV8DQGb3Kl
	0W8YJide37FoCztdM9lX0mwYqpRtV2Syu4hkNzzBc56K2u28sRFiKSlNU9xmFPxsdjMn5kz9p9R
	/K+QAsJhPZhFmnfyhFGPQ81VcB79iXqf2bZ95Q1FYfvqxBbW1fNIk9XQsdalmzJl+PctH1myeWi
	Nv8q/Xd5NaMfWo/TCl2pqG4ayfYVqMK8W+hq9vd012a6RgtCwTR+WEd2OuP2M4BkJr1CWzyekLZ
	rS87zpTaeckSIWJ6/E/QFeWlucR6x//VdKK8HhuvyUQt4TkC2mbj2G74gTZwUrYUhpZOQFxSRZc
	ZRCX8zreBm2dXgyXpsTDw1gCeZNl+cpKy5zzKNOOKhAshZVZTmy3N4U/o5XpdjS5kNQ8fevxhN/
	Yevr+y+QDrKZ9uHmS1WD4KCBVCcICzdKsaZA7IzpFdz8Kh2IXqGeiC3LDJll5dSPedrNlA+hCzS
	Wcs2FwDs3EfnAMrfwlKvGFT033TywhBKFvHXB6m4YJSkkrazqsU6ntPGZXkJotbTactczES3pxS
	djtgCot7hz814D310HgmKJZwnYRWtWx2pPBLNGYP/ZnoXqwbcEiRuphl
X-Received: by 2002:a05:690e:1916:b0:677:d023:49e3 with SMTP id 956f58d0204a3-67c2729437cmr1566700d50.65.1794044805696;
        Sat, 07 Nov 2026 01:46:45 -0800 (PST)
Received: from [192.168.100.12] ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c13540451sm3731000d50.10.2026.11.07.01.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 01:46:44 -0800 (PST)
Message-ID: <6aeef384.2b6211eb.2eba46.0de8@mx.google.com>
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 dev@openvswitch.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH net-next v5 0/2] netlink: specs: fill in the missing ovs
 operations
Date: Sat, 07 Nov 2026 04:46:27 -0500
In-Reply-To: <20261103183319.2730567-1-houminxi@gmail.com>
References: <20261103183319.2730567-1-houminxi@gmail.com>
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

Sashiko reviewed v5 and raised four things. Answers below.

The ufid length one stands. get_ufid_len() returns 0 for a ufid shorter
than 1 byte or longer than 16, and ovs_nla_get_ufid() then reports it as
absent, so a del with no key and an invalid ufid does flush the data
path. I will say that in the del and key docs, and give the attribute the
range the kernel enforces. A new flow that carries an invalid ufid is
indexed by its unmasked key instead, so the ufid doc needs the same
qualification.

ifindex is u32 in the spec and signed in the kernel, and no datapath
request used the attribute before this series, so it went unnoticed. v6
declares it s32 with a minimum of 0.

dont-validate is missing. These ops carry GENL_DONT_VALIDATE_STRICT |
GENL_DONT_VALIDATE_DUMP, so new, del and set in both specs should say so,
the way fou and team do.

The last one is a real bug and it is older than this series.
ovs_dp_change() stores the new features in dp->user_features before
calling ovs_dp_set_upcall_portids(), and that call fails on an empty
per-cpu-pids. The request returns an error with the TC_RECIRC_SHARING bit
already recorded and tc_skb_ext_tc_enable() not run, so the next request
that clears the bit calls tc_skb_ext_tc_disable() for an enable that
never happened. The same key is shared with cls_flower. I will send a fix
separately rather than mix kernel code into a spec series.
