Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6A64078F4
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347215; cv=pass; b=Db3rqDpY3tSWB20Z0ORXW8ZzjhtD5e7cfNs3YmuSpKah8ck6O6avhgUUJe5+X7XadhR8/oSQQR41qhABZ85Agtp16IqmaRGzQ5jBEFEE2tZTGekumLYISm6Gz+szqEe1CKaYqs+YQDBM+PDfcJBu5W83V09qMIleycec/PvsGls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347215; c=relaxed/simple;
	bh=C83oTuXusDiNKwjJ18ywcN71httz/FtidZS4MpxNeAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m00A0zlLS4vLs9lu4i159sTRuetiHMuU1pWv2nC8NcVq6ZybLJVYXVZh6eBuPGXtbjdz4Qvzh9wWM/9QPE8jApLa/Te6/zS3pkOn0kIO7XNvL6476Z3UaMBzihPVee14gm0Z6J7ESPueW1efCidZ+j47RfdNcTLKjK/zU3TrSfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/7YXNyI; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/7YXNyI"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-8748f34b1f2so508604b3a.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 07:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790347205; cv=none;
        d=google.com; s=arc-20260327;
        b=HkWlKU4QSrUGttK8KgSMoaDsShBgSm+ZPH3itJyplbo9Ze29x3Ax0JJEsiGLmOzArL
         3UwniU58Eig47GnE/g0Vca9G4JZCbWqtbkBd0IhXrUsY8NAiFUdHx6j7tyN6dXewHk5/
         KkdESidfIbD9cTaHrR7mdbslkCnIjI9M2jhj6wU6sZnbcwhMTZEH9R3Q4XdVh2VbLGZS
         VJLAZjlkESo/t3a38UKMSC5x1AkYwVt+j7abSdK/PtjF1uackfR3Pz3WpGJCWZ1Tvkng
         4sdHk4BmHongLtefWCb+S8+tsay5RGOmWA4YLQopZ2NjIBIOj627jfh/OAwGrGuMgogk
         eK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C83oTuXusDiNKwjJ18ywcN71httz/FtidZS4MpxNeAU=;
        fh=iIWKGo4qGnD3vy5gh4FhXfO1+9MNMlSzf7iMNtJDq4Q=;
        b=aZrJh7YxIoen8llWNRfWUJlAE0bwBdM3ujYPWhSqZsLr7g60OXFXbRolnNtAP0BNnP
         wgbK3T4k3QWeEdw+rGV24iMNNcIrW+zPXv832cGfjVhl+y+cW65irOiMfqB3SU/DIYbs
         ojFiHFyagKb8sJIcZT1S5QLendQ+sAItgSAkC+jXj5UCQ7XMYmV4mTFhuQ/1+IgftxkL
         nI8BY91ut5nbywj6OOgmRJR+6dw5TbyJLxdJ9pWwFEPw1Lajuy2NPaF46XV6ASnF5CQw
         nMHTM3JEuzWuvDExZSlUzyrPZ1PrSj8f2T8V+91ceW7OCsdUNrFbg9wjbq3/sybv6Cnp
         Fspg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790347205; x=1790952005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C83oTuXusDiNKwjJ18ywcN71httz/FtidZS4MpxNeAU=;
        b=e/7YXNyItBmjCQpXcQxE4wgZGpzoLFg6T4q4XuO/cgfNNXMos8gYZyGrf0Q2Y8yhMs
         4tcN2nY4p5WsZbI2vR1/kSAiktxoT4wmplK4RIH9hAOR3QejI0a5vt4h5cODxQTJr4Zo
         eLMv7xYQ6F15XWI0RRSae0M/CkrR7i2jFN+wqCGQv1I2iAdzieYLgPxW+iEDneCB7n2G
         Bg/fqesT61VC3jPres5oCymCS7wChjK3YvZyxgBualFZeGtBPr0QNSfQ5brhH8ct4ESS
         PVCcnHeE/ALX+96qaELNDTWOX7/KKYckZNQyT3qGD5FuGBW8QwhbTN5wGMII90ZZV1Z9
         z5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790347205; x=1790952005;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C83oTuXusDiNKwjJ18ywcN71httz/FtidZS4MpxNeAU=;
        b=ZsJ+/WlOnP1W+Q/FPz5eWm7scPIsLQRnS7ZCONLDrF/NNTDsWwAk1nS3TC0KIDMaWY
         yHaJUwF1HLn8GLMuyUWBsDaJ05ghO9ETgYNF5x5HNnY/6x+79F6h3foe2aH/g2nejAN2
         XFc6swN2uSdmdC8XUAxh7ToVVcA0mMAgkkY3yGC5XLyxR4nLF8jzN4ib7RLjV7g1Wq5Y
         d2Nnu4LxpcSJExC9riHg8vpOLJzSY8XjstOJgNUJihXqdnAUe/GeHPhRdOw1N8CvcpKC
         s5LJ1zVsA9EM6mA3/zTth7dnqRl/ieNyzJf2cip82hh0LHG+OOubuteasXWtQMajG7oV
         JHNA==
X-Gm-Message-State: AFuF++nh3VKKghseUHdFpwQApy1I+Z9nm8hTwYDk8S1KuytEW5BETxOB
	UbVVI8jb7eqNXZLaSzyL6njL+bT2cGNWhic4YgGh6pmdfFtoHbN4XgX7spVxAy2G0bXB6fCvCAv
	NKeECPqGkCu0zIZwebWU69tKpnnJj+sU=
X-Gm-Gg: AYBFou2jhNXLeX1K91NF0qYNXmjGGksCtz+OirmBaYmjdAE355fkX69PsIa6j+J+29G
	hiQc4lKYKKBbzD68ADo+3qpQ4/u1GN1Wkqr8btYql9EcMJU8N011iq49yQ3Et8AYVtLXeCcq9uJ
	csapmQdihRUIDeAf1lEDcQpQW8Ikz7Ndx6eu4x7MdZ9htqXoTicZ3IEUaZxmR8WI0bKAw9wTGjh
	8J/RO5JgWTHan663rfta9fAduxhhhyNC+UvklXDnqgoN0S4/XpEBKxsbxflDMa1Qijbk01ZDUIe
	oTPzICAPdV0/yRJsnwE54QxFH3KcvcMBjEgPrvfK9zCFU2pKDxUnFG5iZvEj3P4opmVs6w44Pko
	0u+kQ7EWCw3m/M88JDQ+GXg0cejaHZ16VSzu93ObPsH+C4N35yec8dw==
X-Received: by 2002:a05:6a20:6a08:b0:3dd:a197:cf20 with SMTP id
 adf61e73a8af0-3de0e8e72a2mr5267114637.68.1790347204371; Fri, 25 Sep 2026
 07:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-4CSL.v2.20260924114800@mojatatu.com>
In-Reply-To: <QDISC-4CSL.v2.20260924114800@mojatatu.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 25 Sep 2026 10:39:51 -0400
X-Gm-Features: AclHuK8gVZp62vkthgFM_M7aNDmllGSluoXwPOdoWj0sX3mgmB8hyAR2Qnd4sf0
Message-ID: <CADvbK_dV9M3RhnXvoBzd5rfNPcYGy4F=DHUo_dBZzrBw0MGrbw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: cls_flower: exact-match ERSPAN key when
 no mask supplied
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, stable@vger.kernel.org, sashiko-bot@kernel.org, 
	hybris <hybris@mojatatu.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 8:18=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Commit 292207809486 ("net: sched: fix erspan_opt settings in cls_flower")
> removed the unconditional memset of the erspan_metadata mask in
> fl_set_erspan_opt(). On the mask-parse pass, when userspace supplies the
> encap option key but no mask (TCA_FLOWER_KEY_ENC_OPTS without
> TCA_FLOWER_KEY_ENC_OPTS_MASK), the !depth early return leaves the mask
> zeroed -- a wildcard. A filter keyed on an ERSPAN index (v1), or dir/hwid
> (v2), then matches every ERSPAN packet's values instead of exact-matching=
.
>
> Default the match fields on the no-mask path the same way the with-mask
> branches default them: v1 index to 0xff, v2 dir and hwid to their
> exact-match masks. The union cannot just be memset to 0xff -- that would
> re-mask the overlapping timestamp/sgt bytes of the v2 header that the
> commit deliberately left to 0.
>
> A mask and a key that declare different ERSPAN versions describe differen=
t
> union layouts, so the mask would silently wildcard the key's matched
> fields. Reject that combination. Have fl_set_erspan_opt() report the
> parsed key's version back through a u8 pointer so the mask pass uses it
> without re-reading the union.
>
> This is a follow-up to commit fee10655709c ("net/sched: cls_flower:
> validate mask pointer after nla_next()").
>
> Conditions to recreate the bug: add an ERSPAN encap-opts flower filter
> with a key but no mask (raw netlink, TCA_FLOWER_KEY_ENC_OPTS present,
> TCA_FLOWER_KEY_ENC_OPTS_MASK absent); dump the filter and observe the
> match mask is zero (wildcard) instead of exact for the supplied fields.
> For the mismatch case, pair a v1 key with a v2 mask (or vice versa) and
> observe the request is accepted with a mask of the other version.
>
> Fixes: 292207809486 ("net: sched: fix erspan_opt settings in cls_flower")
> Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2026082602512=
3.62758-1-ljp1205831794@gmail.com
> Link: https://lore.kernel.org/netdev/20260826025123.62758-1-ljp1205831794=
@gmail.com/
> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/netdev/179003833955.2160803.107768171639185=
8800@kernel.org/
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Tested-by: hybris <hybris@mojatatu.ai>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Xin Long <lucien.xin@gmail.com>
