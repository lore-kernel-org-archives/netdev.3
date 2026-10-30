Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793380118;
	b=1gvaGTFKFdei/Sf7otNR96W51sKlLiztXiLSQ49xnC+Pr9vngw5A9IHNjbqVNUZj0FkL
	 jvYzD5l5jw9LOO5JjrlrRTtvrvB83PgLEkKOedz16SKuztV/oRInwBG/x57yn05BECM6m
	 cmhvaGTIJ8LOjBU3Gt+V8d7RHdlSSD+DSBYNoE8rOrHMx0k+HP5FBRlZsxxpB+estGYLy
	 pJTYJgE4gZ1XrAp1CJ8CprFidZfgvPdKAQbima3SsQR3A/rR08rfJF8qFEHwXpuSbvspc
	 fqVDWNevoEkGkZMOBIHwrF1+SBIYo6bKbB1T+DAOH6ZEXtLzrDgxXKxORB07AUUuhGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=HxML07JrVrj4RRpOs9TXwwC7f4fwJda0Oemp7EKVGdA=;
	b=Tg+/0Zy43gm6cQBXJ3lRWuydHVPICAISevMftgNPMd6B6so2LPBHvAwLoQUhf07Ec0rs
	 fOpF6i0KDSB5RUwDOVvCLxfsJE6LfTe6NrSUiPIg3ytT2P4JA5QN99ADyfPyehxwd0PO5
	 xgw/t3W8xrCPSHY7HkO1rCdMgHzTFHqDQWjJahzHAOC8XH9fCy5Ls5XwtmfnVbp4SfjLW
	 iKyLkVtJ4abaHq8iS3CKhlCLxldTbjnS5ADZSA+/Y77nf2JldvT4F/9L6Qtf5b+NBiXhU
	 wiO1sP8Vzi+ezBIAH8+UFxMZdZgA6euX9Y+TxW1rvReeyFhnX4MM4c2ZeKFx0lpzn7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DzvdKKji;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB33606A326
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 17:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FB33606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DzvdKKji
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36a1947498bso311101eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 10:08:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793380117; cv=none;
        d=google.com; s=arc-20260327;
        b=q90wafbYDh85y2TNVKNHoMmUpmOe/qRZ7nuOjnVJ1Ulx0Hb089FO6Q1WiJhSHxlwHe
         +FwyCt4BM5NwDTEExt4eFjRj5PLYlFwUfVTmzHntKnzqe7FC64mPpNbMZWZO+z7xUkRL
         i+TN3zYzgFMBac0vyppoK81AvTYSRALxCmjoN294u/p8CNyI1bnsgZwPXjB7kwuyfs5Q
         w+kuyEvPGh70MGhQ2oQ27JmmSTkV+VXjj75kM/bfaulNR5GL4E5nh4eGp7vRnGZg5GIl
         Nfqyj2TcsXR4ciZiuXagHNghJEJ8TfJJZhae5rwxVzCK5cJCluVhKkN+QCaNTOkciGHo
         r64g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HxML07JrVrj4RRpOs9TXwwC7f4fwJda0Oemp7EKVGdA=;
        fh=VAPGHN2ET6WMnhZNuwdaTv9rYemXIsWZY2kHCEaeE1c=;
        b=oBuGHOo7nf0Vl8xUCFVOYA99bqHyj6M/NaHCsSn34UXde8coRi4lJlgfQNHZSrKY4f
         uAFIdpQRUjmMIcK+2uQ+WmwTqozQCy+lT3lfx7jdQmrPIt5sYRvsW6lcXrJaxNhDUiUX
         JVMqUljK/heSkbNFpy92iB0yjts32T9qC8HlAXFUi3CngTJTIcQJQVj9pfABkn43hHF0
         UkYX+/rqhPUeIrMJGogHDddolBwhBpGMi7gp+JE3X6DDTQP8O4LJiCG44itEi6+iYTZT
         0OIOPWA9881kpzuIIPFEV2AZJ+jA2gTjMi3de0nWmjMd9t+m7zB8QkKEcXIn2FS7egeY
         r9tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793380117; x=1793984917; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HxML07JrVrj4RRpOs9TXwwC7f4fwJda0Oemp7EKVGdA=;
        b=DzvdKKjiubsVbMwKzsQ7OZz2Imxqi+00JZUqKyxM8AOizqzIOyKcW6VOykfZwiIHGF
         57cMPbwdV+ny3p3vnIld8EStmBo5eIvqQ50ThFFCUVi49IorC9D2QtXmQ60t7QUSIaJC
         AhANEJLnTC8IkzRYwMN249nWNY1gYM+976/qNZEBbrEaj6Ohp3I9L2giYdp/iU358Kms
         WoRsCYo3kgG2V8NOqNY5x/JQeC6BIKYP7mnvMp2EBm3CquEIkQjdYY4y5naql28TjYx4
         od8G+VEDCU5zrLYUE89hS+u8fxyYybDFcLmiHfmxPrRvc4n5fdCmGyf5TaII8Xf3NgiS
         DmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793380117; x=1793984917;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HxML07JrVrj4RRpOs9TXwwC7f4fwJda0Oemp7EKVGdA=;
        b=HT4AolgIU8Ves96L+KDMNQoSSivsDWnxt0Gm2mRLvU84JQ4VBu3uQJcqTEK2mjdGvN
         AThvwkpuMIU62OXaSv5Cgi784usYED1VHH+5vTUvis5YVMfr+A+ds4SoxUY4WzZVSM84
         XbCieXJxN3Y9aGKK3eSIFf611xhRfQirz+nYfZP23NdROcjnRavhN6U/d21q5KuhHr80
         Ce1tWsURus0cMDF0r4YDoKv8DXOiYlOMOhWXBJXxZsC89nk0V9VqR4urjx/U/Oq71rNW
         /H/HxR3y72UVA66Ik4iCdOoAmspSLdqVswK8dq+5GOTnKx/d6y8zhlC1YrAOeHwsAhoj
         6lpw==
X-Gm-Message-State: AFq9FYJNZ3mHgfV5gxAcY9tponlPMqH5abl8129Ds8Mcs+LWGPG2ZdSt
	F1wmGX7l87gdxVVUxGTl7WmFF356vJSlmunuRArNKC/j0BkES5dQtaKnkm7V91xFoa+sp8oQmWK
	NJu4QZHw3u9lMBzQal2Z/C3L4mJhEJYQ=
X-Gm-Gg: AYBFou1pWOqzyvKQX99PiGQX0Fj+8mGykkt6Zu9/Fd6PiLHlKgLjr1hm1zNyc58w4jS
	/x7R6pRvZfKFUKSgfwkAR+7Xjbj1kevL8xcGtp6TpvGBAgRtSbR3NEwkneR3aPrp4VlOD2LlmdS
	c/kV+yVjwqbNuhVAocDldD/+7eFfkB+BlUJzp/Dyr1V/KORPxsGb/FYNxaszazuCmVQYUS+Kwft
	Zes4RvOXMY0toE3FBQx9OLGRnGsR70+Z6XWQDxMoWGbQhFS1gZ7s70moyoMc4AtYWuglicHvsdK
	NCHHcO49MB4rP2JPvVw4nsFaofXWFyuwG0f3mHKGj1RnargRQpk0i3LpUZGbCChTcWMvX2jBKd2
	hVFiRBuZ64piltxYY1WnBwlBXgMN+RCi7KzaeGgBEh7CpnMp8lP2nCoNsQA==
X-Received: by 2002:a05:7022:628a:b0:1a4:c892:b130 with SMTP id
 a92af1059eb24-1ac5b9cb62dmr4974858c88.15.1793380116576; Fri, 30 Oct 2026
 10:08:36 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028104758.299129-1-timur.stukan.linux@gmail.com> <91955.1793289071@vermin>
In-Reply-To: <91955.1793289071@vermin>
From: Timur Stukan <timur.stukan.linux@gmail.com>
Date: Fri, 30 Oct 2026 19:08:25 +0200
X-Gm-Features: AclHuK_q4UB9KXrhigTXAjvWJSIdR7qM0bZtgDXcbgAdX5p_OjAdmHpPO-SNVk4
Message-ID: <CAF+_u5CGDY8m_abiXMZFboaSnfShmFh-c_EE2EaQSOQOTu0ezA@mail.gmail.com>
Subject: Re: [PATCH net v2] bonding: fix missing down path on speed/duplex
 failure after FAIL->UP
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Hangbin Liu <hangbin.liu@linux.dev>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Fernando Fernandez Mancera <fmancera@suse.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Oct 2026 at 17:51, Jay Vosburgh <jv@jvosburgh.net> wrote:

>         Reading bond_commit_link_state(), for this call site, all it
> really does is slave->link = slave->link_new_state, when link_new_state
> != BOND_LINK_NOCHAGE.  The changes to ->should_notify_link only matter
> for the ARP monitor, so that part is effectively a no-op here.
>
>         Therefore, I wonder if it would be cleaner overall to not do the
> bond_commit_link_state here at all, but instead keep what you've added
> in the BOND_LINK_UP part of bond_miimon_commit, and then add calls to
> bond_set_slave_link_state(slave, ..., BOND_SLAVE_NOTIFY_LATER) to the
> BOND_LINK_FAIL/BOND_LINK_BACK case to make the change stick.
>
>         A quick hack patch that I have not tested to hopefully
> illustrate what I mean:
>
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 756d79281ffc..5fb215fa85f6 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2877,6 +2877,8 @@ static void bond_miimon_commit(struct bonding *bond)
>
>                 case BOND_LINK_FAIL:
>                 case BOND_LINK_BACK:
> +                       bond_set_slave_link_state(slave, slave->link_new_state,
> +                                                 BOND_SLAVE_NOTIFY_LATER);
>                         slave_dbg(bond->dev, slave->dev, "link_new_state %d on slave\n",
>                                   slave->link_new_state);
>                         continue;
> @@ -2933,19 +2935,8 @@ static void bond_mii_monitor(struct work_struct *work)
>                         goto re_arm;
>                 }
>
> -               if (commit) {
> -                       bond_for_each_slave(bond, slave, iter) {
> -                               /* UP state is committed by bond_miimon_commit()
> -                                * after the speed and duplex check, so that it
> -                                * can still see the previous link state.
> -                                */
> -                               if (slave->link_new_state == BOND_LINK_UP)
> -                                       continue;
> -                               bond_commit_link_state(slave,
> -                                                      BOND_SLAVE_NOTIFY_LATER);
> -                       }
> +               if (commit)
>                         bond_miimon_commit(bond);
> -               }
>
>                 if (bond->send_peer_notif)
>                         bond_peer_notify_may_events(bond, true);
>
>
>         Thoughts?
>
>         -J
>
> ---
>         -Jay Vosburgh, jv@jvosburgh.net


Hi Jay,

Thanks for the review.

I had the same thought and was planning to send it later as a separate
patch, but doing it here makes sense.

I went through the possible consequences. Without the loop, DOWN is
also applied only when bond_miimon_commit() reaches that slave. I
don't think other slaves handled earlier in the same pass can be
affected, because when each such slave goes DOWN, its own link change
rebuilds the arrays and redoes the aggregator selection anyway, so
nothing stale is left after the pass.

I tested it in 802.3ad, alb and active-backup with downdelay 0,
including two slaves going down, and the original FAIL->UP case with
downdelay. I'll send v3 with this change

Thanks,
Timur.
