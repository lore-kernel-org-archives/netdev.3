Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB55436BCB
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011149; cv=none; b=JjnpKKUSiBw0vjv/g/wLTROVzHQobL5WSQ0m+qfQgwXQjXfk3iJBlpxBTDKQ1/e/SmxhJbT5/ITlqXq5mfG9/SUumlwfotjdKiuEzyG9aqKkHmmIkzqpltc2+/DTiZQ+JbzBQtq1/c0+j3x73Rj1WTmh05kD2Ypf9gGqi7W2MdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011149; c=relaxed/simple;
	bh=aAq9lw5aq8RYaL0xpQ9nQVP3sTZFy5k1cgm4NiwNvCY=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YHJpROs+8K/Min5lGgCqPwhFXeM9+cLlmREvTiPnJgIGvtqZcOxHzrac4fmknFWFA9bEycfz+n6XXnak1ShGcs3oIr8TsWOLQthKL1hOdUj8kok1vvUuXqnRoQfog9OIDuBWptK1R7T9ojeEJBBHdI3CfCiuTwfsb2qPM0EzyHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIN8v/6C; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIN8v/6C"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso847087a91.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786011147; x=1786615947; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jwPvnHnNY5KtRjTEjUBgn4OJzPCZ/4RYDCW24QvykqE=;
        b=IIN8v/6C4BEiG9q/kFVn8sCM9V5dCbNxNnoO0XJhBh8joCTEPKAO99FcjoOPH2Oyz9
         CCj1FS40sRVASW1UQkXQcje28MV+YschIUcQiam4zDZo3mU40lvV47fd3TFHYhv9QALE
         vMk0qH/9QtQ6uu9313qfIra3E9ocqS1xj+XiGnj1j8q6ezXu2kdQ+kDGG2gP3nyazOIY
         Mi/FUXMBEkzKtRBLnN99P53eL+rIINj6vrwxEzM3JklDmf4p7C/cisPBwO6n30pUr4je
         pdgV65WWCRbNZZbUaC78Xgo3ZLt6lWE5bVL+NpWXatUW3NtoXiFneHssZGkvLKZuvQwd
         7A+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011147; x=1786615947;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jwPvnHnNY5KtRjTEjUBgn4OJzPCZ/4RYDCW24QvykqE=;
        b=flscHlfe02k5ajFba2aqPQs0vEr3g+IeLDGADoIm+lI8MgZrLFKDMt8TONKA6nyfXd
         BqyVyMQJcpsbzuw/96CwbVFqqONBt2yuLPzJ4dKdefA+Yu6q+n+CkBOkY4ezp7ycVLKL
         it9Pb688R1z1vRdbGN21twNwmc0PrL6C5FFdaCYQSI63Kohsgp3JsyJNajUbEODGgwcQ
         Y9G3f7lPvYHRfnotsq+RUVpI9a21p0iBokI+esbu2GZ0Hz2PFB5K8+7icrBsCToh6ux3
         9fFGo58Jjb/jPgtc9PBqVnHWAN6YbitOp0fVuhY0+lyM4TTDW14JsgnPVoLCd9nt3ZVZ
         zlBw==
X-Forwarded-Encrypted: i=1; AHgh+RpmvmNjzOR685ORPf5AM3Q3JXX0JV2+hYheduxz5F18FWVt7Q1hCQZECrwLZ9hNFfzVa2dCUC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8VNndv8K6nui3sx+vCmUN9qbWLH6DTqlHBCmIerRBWmXQClB+
	APxby0tzzVYEOK3ua+djtECiheV8t+Oznl1gxgbp2nn9GiTkDTxSt7Xt
X-Gm-Gg: AR+sD13q0lkdef3rGc59N6s+KpskV/P0y6s/ZgoPk1jgYOKO5mcT1ZCZFyfXSQnlvTD
	XIrS1CkOEmjLlPjT5+uPYo+BPIC0yBDTKsj04zKn7wEpM/oixTyvQ6D2brnOOVHcmqhDXhEVu8X
	MrgIzZFkowCyy+X7ikuV9R7UKl845pUkEJK5AQZSZr+r+czx+CX7i3CADOvHWXnQzW+G9/0KTuR
	Uc24fin8laQJuioxUxuek99p2iaQXO45YCz2djExwgyOdEMOd1D/PmxCa3ezf+93ljoXJEaxC7v
	x0zwpLPOi9iyz1uv1ZZkNsoJ+pVZOn3TScDUXxLV2waOncumGlNgOr7/5kNh+DB8H6TpznUL9tN
	6Ldp/YW9v2Vm7EFUhQM7R/sfXUWiuSLfqc8T2s7NwChptoGw8QyknvJMTiGrdvNBgaYIftV8zGr
	KlFP2GvQqZe4q3SCiGgD1jIv7vdVABvFhmIDn8UIaUTlQ/l8eSzq8KXlFH0J1rV+aMjgE7l2N2x
	VXFpqEk1op3TH3s+bD+9KAGe+dU3dUcVibEQSGvD4oiJDxX97o=
X-Received: by 2002:a17:90b:2d87:b0:385:3ab:fecb with SMTP id 98e67ed59e1d1-3908972ccc2mr1351738a91.4.1786011147110;
        Thu, 06 Aug 2026 03:12:27 -0700 (PDT)
Received: from BOOK-P74QMIQ7E8.localdomain ([220.73.18.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39086164982sm1229297a91.16.2026.08.06.03.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:12:26 -0700 (PDT)
Message-ID: <6a745e0a.dde95cf2.1d436b.2244@mx.google.com>
Date: Thu, 06 Aug 2026 03:12:26 -0700 (PDT)
From: Hyunjung Ko <hj351016@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sched: act_gact, act_police: range check the
 fallback control action
In-Reply-To:
 <CAM0EoMniQBhncxxUyOVLt-EB-hwE=P93p-hS-U2ERkphmcEsLQ@mail.gmail.com>
References: <20260805095527.204088-1-hj351016@gmail.com>
 <CAM0EoMniQBhncxxUyOVLt-EB-hwE=P93p-hS-U2ERkphmcEsLQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Aug 5, 2026 at 1:59 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> 1) We test almost _everything_, so to get a review - even if it as
> trivial as this: Always, always send a test case to reproduce even if
> it seems as obvious as this. Preferable will be tdc. But you can send
> or point to an AI generated poc as well if you cant ask it to create a
> tdc test. If the issue is sensitive - send the poc to the tc/netdev
> maintainers in a separate email.
>
> 2) If you got assistance from an ai - please add assisted-by tag.
>
> Same goes for your other patch...

Thanks for the review. Both points addressed for both patches; v2 of
each follows shortly.

The act_ct patch now comes with a tdc case (2/2). It uses the scapy
plugin to inject the malformed IPv6 frame and matches on the clsact
drop counter, which turns out to be a clean discriminator: before the
fix act_ct returns TC_ACT_CONSUMED, so tc_run() never reaches its
TC_ACT_SHOT arm and the counter stays at zero while the skbs leak;
after the fix it reads "dropped 10".

To be straight about how far I verified that: I do not have a
scapy-capable tdc setup, so I have not run tdc.py over the case
itself. I ran the equivalent by hand under qemu on both an unpatched
and a patched kernel - same topology, same ten frames, same tc -s
qdisc show - and got "dropped 0" vs "dropped 10". The JSON is modelled
on the existing scapy cases in the same file (3992, 9c2a). Noted below
the --- line of 2/2 as well.

This patch I could not express in tdc. iproute2 only parses symbolic
control-action names, so tc(8) rejects the bad value before it ever
reaches the kernel:

  $ tc actions add action gact drop random determ ok 2
  RTNETLINK answers: Operation not permitted   <- parsed fine
  $ tc actions add action gact drop random determ 9 2
  Bad action type 9                            <- rejected by iproute2

The fallback has to be planted over raw netlink, so I have inlined a
self-contained C reproducer below the --- line of v2 instead. It sets
up the clsact chain, plants TCA_GACT_PROB.paction =3D 9 and then
TCA_POLICE_RESULT =3D 9, and reports skbuff_head_cache growth per
injected packet. If you would rather have this as a tdc case anyway I
can write a plugin that does the raw netlink setup, but that looked
like more machinery than a one-line range check warrants - happy to do
it if you disagree.

The AI assistance tag is on both patches now.

Thanks,
Hyunjung
