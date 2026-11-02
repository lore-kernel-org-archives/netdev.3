Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793603155;
	b=VPdPactcWcFqCJWXOMI0GTdt/crc+TwLcxeItU1i5sP+ODWDsjHf8ccU6mi/fh/RstUy
	 vu9JwaAABHSq0uW0rMetAQXEcXjO48PpZmm+aZTjuovRtMjzeU40kV+9bNQYndJzbr3NR
	 l0NtS1vwYupahJgiU6W2OfTOhzzkQ4ys5c849x/WYj0bzgVEfZs2sZJ2+80oNfqiAw1ai
	 WAqSj3n2D1XGFjJ4ZiZ+YNuemFLQ73+kDMCRHBUwOxILoja8elWp66D+hgsI9NzTSDvL4
	 XBGBxrL9D1pJoEv6k6K3d0w1Dwg5YOzdpku1IhrdKNdtYSahXsHFp7axu+TIwq+IU2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=S2dXtgoINO4jETLhwlkbR6oePZjzayLB0KbxKdo2N4Y=;
	b=s3QcicJckpG4WvsBMnTYvKy+gfw0Qc7O1levP3krpouPNpOKh4UmDH6TZBZDd9RljDaO
	 WdociluzUK0XGmZHzzXC5j7TO6gUsZ2/6SNOTifDhUMq7G6j94mZHE3nIAlhh/xfOPf5E
	 82/UGFHvZVY8UFvF6vRGaGkwXv7LN5VLbCZmProS3GYRiD1WCbAx/38i5gK1lLXxr53V7
	 a6WnT7zxtZSDjAyrIa5hOl60K94GFcVP+S9q7n810jWShQlCFe4QEYhKncEo+xmtQsM8W
	 hIuOxeuR1VmkfIPZRbAXNY0kRYBBkrkLs99kjAo/tuAPKQcuUWjodm1vVG26eH8P3QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--starchang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FAEspZHC;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778AA606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 778AA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--starchang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FAEspZHC
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd60a365440so1744043a12.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793603155; x=1794207955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S2dXtgoINO4jETLhwlkbR6oePZjzayLB0KbxKdo2N4Y=;
        b=FAEspZHCbWAm785Gemg9wThR+t7q2ZPqZP2E9PPj43Uu0kn7vvjNsV9wRCBPy8RPe9
         0gnetozoKglOKincqWsuisrthjYnwO2uFIG24LFxV6lLtOw/jkaSszjaQJDxb3nSrSYr
         2DnOex+n7K9VwpQgI4+JjCMJ6XjAztLeRg7Aj1FMnVUP/1xe7fVzgfyXt2Ri/eNinN6d
         6tQCIKYrCPRCG7m/+FzaYT8KM+ZFdi8YJxeIZbrCaa1m1LEgGkG0wOHqlUDH3eB+mhwu
         b/NAVdUIvQcOZi5JTezWC0j6q6AlZXj/BZB7o3Q2XoL3pNnucK2A6FiWzVtLRYfuy3fA
         JwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793603155; x=1794207955;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2dXtgoINO4jETLhwlkbR6oePZjzayLB0KbxKdo2N4Y=;
        b=vgVBWxUTyfFIAeVs40Tc7qI2IakSLc5ixwOdNfr/KP65IUFZGnxVC9b/MYuLPCD7sY
         ZJaMXJc7IDvuBwA4YYBqEIdqdPxtd4d+ihhJcR+bffKMr0PFWesbKLx0OyxinfRTcelr
         VPLtWnVtLXF1OOZVfCfkyZ1Sm5ojhq3Z8vjaLtHT6XpRpih5wlWW1UCBFNMhyo5fHdZx
         HvwwMBZ1L5ggNbeB6RPJPk7pDAl/K0yftn3vflSOWl68sawFO5AjXwOD5KmDNnw6xvnj
         FWhynSBP31c9edqr4nTgfU7kGtIDS0HnoXSyTPRpYiQXrpXbciDXd2Cla9wtjniLxkko
         7hEA==
X-Gm-Message-State: AFq9FYLDJ1jaNn0l1jExPM1/QmOmnB4GqrBaH9GomxTEp67ro9HzynSg
	NH0Ieksem0eN+RIISlNlNRnl27cTgsUCNd7ff7GhVIM2C8sL7KY8E/LlGNMGNwud+ALUSYNaW7l
	8A5apOdhgpUXn807OtQ==
X-Received: from pfbgq43.prod.google.com ([2002:a05:6a00:3beb:b0:8ac:3a52:2231])
 (user=starchang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9148:b0:3e2:ad7d:382b with SMTP id adf61e73a8af0-3e929019698mr7099554637.83.1793603154652;
 Sun, 01 Nov 2026 23:05:54 -0800 (PST)
Date: Mon,  2 Nov 2026 07:05:52 +0000
In-Reply-To: <c2780bb291244cf32c1dbda63f0dcf594d22da30.camel@sipsolutions.net>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026150539.1357037-1-starchang@google.com>
 <20261027015619.1745984-1-starchang@google.com> <5c1fe870-39ff-e83e-e479-0e1f0fed6a83@ssi.bg>
 <20261028061644.2997812-1-starchang@google.com> <f631e178-d9ec-f335-9163-c44a9e6c58af@ssi.bg>
 <20261030030715.604215-1-starchang@google.com> <65cf2338-7bb4-3151-f3b1-ef171bb5723b@ssi.bg>
 <c2780bb291244cf32c1dbda63f0dcf594d22da30.camel@sipsolutions.net>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102070552.3516567-1-starchang@google.com>
Subject: Re: [PATCH net v4] net: Fix Hole-196 vulnerability by dropping
 unicast ARP/IP in L2 BMC
From: Star Chang <starchang@google.com>
To: ja@ssi.bg, johannes@sipsolutions.net
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, wangroger@google.com, 
	starchang@google.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Julian, Johannes,

Thank you both for the great discussion and perspectives!

Putting the two points together gives a very clear and coherent picture:

1. Julian correctly pointed out the real security risk with Hole-196:
   Attackers can abuse not only unicast ARP replies, but also broadcast GAR=
P
   announcements (sip =3D=3D tip =3D=3D gateway_ip) to poison peer caches i=
n a
   shared-key network.

2. At the same time, as Johannes reminded, Linux already has a dedicated kn=
ob
   for that specific broadcast behavior: `drop_gratuitous_arp`.

Looking at the existing architecture, the two knobs complement each other
naturally:
- `drop_unicast_in_l2_multicast`: strictly enforces the L3/L2 boundary by
  dropping unicast IP and unicast ARP replies (sip !=3D tip) inside L2 BMC.
- `drop_gratuitous_arp`: drops broadcast GARP (sip =3D=3D tip) without tang=
ling
  broadcast filtering logic into the unicast knob.

This means users defending against Hole-196 can achieve complete coverage
by enabling both knobs on the wireless interface, without needing to overlo=
ad
`drop_unicast_in_l2_multicast` or change core neighbor learning behavior.

This also means [PATCH net v5] (which dropped IP changes and strictly filte=
red
non-GARP replies) is architecturally aligned. We can document this dual-kno=
b
recommendation in ip-sysctl.rst so administrators know how to fully secure
shared wireless links.

Julian, Johannes =E2=80=94 what do you think about this unified direction?

Best regards,
Star Chang
