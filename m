Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA963246F4
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170355; cv=pass; b=XQrZgt3VV+5LUHfWXhns4+llRlqz2/oHmkNFt7L5wVvj63qkvvsYvjMj0jfWsyModtVWIuBivWxSjCxWdLonlaOZXpBzvV6lMQeDdw4FDAo/b/CX4r7CGSPm0JLYHa1MYJE078/YYr6eOEJA3Muv/XONEltdHWG6OefoJtWNXqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170355; c=relaxed/simple;
	bh=HFj/obFOXaUrFy7Dz36eNeZIP3Dw6LmoxFR/Prws1fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKUZ+yhh3HwpAbY+ezGkp0ubgRNZl7pi454P6IDEX1rlKpv31/bCn1Ey0dbZzhephqZBBiPb97o6wkqRr4Pe/nNtaEixhMsINt2DGycduldsjeAuo9MQxivpqBpyhLbmHgr3X5jUWPOeRg+AgPj6BivkBLyUU867grGE3dinCPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pisgcede; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pisgcede"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43f9b119so14843207b3.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 06:32:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790170352; cv=none;
        d=google.com; s=arc-20260327;
        b=LmRkCP1zmmlf06bcV82bP6Xy6PQ/709VSW3/q8cHrW9Wf34MXAOGR8XH6yytEHlHEJ
         TaYPYTzhiMJrTQa2/L3Z3LKZ61YlsSNa5R8+bFkqoah0BpHUfRbHNo3OZQd7QmNQRIgL
         uKgj+t2IFq3eeRxHVqXpTpYUKRjpQej2VU/OMH4gsFyy8UKHHrH1w/HnaI33hnSXP5+B
         FXEF9KRAU+iry33ezTp8/n5ngcm1w7czPBuG7jdNc2oedj2oU/y3T6pUyHGK+YdO8MrD
         jixuUDD6ScKQbRVBLFSDBJS77xsbYKtWqwTjm4lS5/6E8TdHR/+J852VdK8m0Tl3zSVW
         n+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+KXKbg+/vq0efEsOnUfo7nGAJCLpwCKe1MmmSmCgjy8=;
        fh=+QamZ9UiKndnjRSYvXX4zLieQpl/U6HU0HjTByegx+4=;
        b=W5gdy8VqOyXY6tMDf/UZBSx7cKVOsSxnNYC6O2tpzIAY+/ruKKKZvQSoxW1oFapSY4
         NnC+Frqs/FMuhIKOrLyB05CvVRYTvvpCuXWaJeP++5MDu86KpJ271G99s6J0tj6oK+0r
         qo7bGS88TGBBVeglklxafdwxUg/dWhe+IOtDZUAGH9FIs9jAk8nLXMDSOsd7w3rg3fHL
         MkA3tgN3o64yr+mPjhdc0NPB4VkfmUpl8vnu2xk+h8XWrQjqr1Huu3NIzISn+t0n7K1M
         VRYUkzwzjnBLYkYcH4vh8IU+JzN3FXXDu277bO+8hW5Vp19UMdCJ/eUS1RHXzl6MPgps
         edtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790170352; x=1790775152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+KXKbg+/vq0efEsOnUfo7nGAJCLpwCKe1MmmSmCgjy8=;
        b=pisgcederrBsRoY4XNzZMQ6y+psbbImhkjFhBRbOqSwYADI2OV3FuXoC4kLRYcQycF
         t7yXz9Z+ys9vui/zXsRMnrCzYGJZOf2pg+ub5lawxt1abh3KOe+C5P2BLLd4Oz2i4E3P
         pxSdP9eiePoqHNst6eT1TOdfDRVFCJD2C+5Q7bX6naeTnSk5n+fQpHKJ7JUir24kV9Ep
         lWeh3Fii+OlWDSD44iAxR+eAQNbs58LXxKs0vB+FJQTP3MZikkHRpvZGdz3j7w0JZwiK
         rQK+Cussl3IGFLpNkQWFTMixoeZh1sFA4DM1Cuq5HyyLow7Jmzt8GKZIxjVDKq6JdzJp
         To1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790170352; x=1790775152;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+KXKbg+/vq0efEsOnUfo7nGAJCLpwCKe1MmmSmCgjy8=;
        b=eBfXInuYNwpVM+IvrupDKexWR8gMXPcSX6uqvOp87J5J2KbZeVo7tXaCIsgUDhgaj0
         cOeqpNziMefoPmWDTTxruLtBdJHR36n07e646h5oOSi6ZzIFC9CJSGei9scG5pZUwj42
         ICsWvrIiN6q0MlsX3Kwn4eZRdixWErL+nrO9qPC5GsgzUojwnO67aJmtqOfKJyX+/de5
         faL4ChAeK1xD7ciqLtybTSO9KtM944ZUAZKi+epzUByeTkVOAuGQn8pGEqaFEpzVn1sy
         h+ZZqLRBrl27BM3zhNa66Y79IIok6lDLnTjuXYLrgJD/FPLzrghVRkqf4AyjoGyO3gc1
         938A==
X-Forwarded-Encrypted: i=1; AKwUvBwCtkalpvIb1TGAcWVy+Ce1nrzmRY/goAW3oKIsM5jEIm1/PQ4f6r9QiFUJYgPStrCrb5nOCbc=@vger.kernel.org
X-Gm-Message-State: AFuF++mXbbSzAG0HbwBziTHyIFG2bctDzKlsMC/PblNzYARRBD1s4qAS
	ar5yvW0vQhg8fjAsmH5Ie3w7an2wSur6gxTgSwLjDTuXNxjRL1tuH+LaueWonT9tE3hbBqTIZDq
	5XzM1YrFxCdV8EhTBfQ0ruk+DQ0HlkLMI+j7BB1/U
X-Gm-Gg: AYBFou3Vf6UjFNuEnXd6RIMofaf1hnSkxdRQGo4pMhosQZHH7Oq3B8Ms/keCTeB5KQn
	IJqP7I+kdfV9umSbjd05rXJ21MJzZq7ZUO/XErbUcHdaLbXJ5Ddzloa1K+/+2Mb+9VHHisAzDLd
	BYuF7vpWiwXqNRG9lS/X6tDQXkouGbOZyRCuC3V+p0vCFoQEG7wRQX4V6+rS4fBs2rxoOk3SdM3
	VALkjJdnHdVKhRU+PaITNiYYhKUB1r/ycnLyBVCeWSVLPy1385AysLcQHE+FnqlEnowZrU3KaWm
	HzWgu5Fmyw8vTvR8qw+y7E1iWS+QM0BAXfh1+eRgKKldr3lwmbNIWhQ7xMzn8DzGVwi1gviolbW
	lVX73w+K8SXenDaoVxsX0ukHVLNGQTPNlW+YNFNNFRmvSpgb4KSJUcpF3yyvufi8v/eeC
X-Received: by 2002:a05:690c:4990:b0:873:5ddf:d86d with SMTP id
 00721157ae682-8a45b48cd79mr15565207b3.56.1790170351507; Wed, 23 Sep 2026
 06:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922095747.3059954-1-edumazet@google.com> <179016837127.2160803.11508533385406825812@kernel.org>
In-Reply-To: <179016837127.2160803.11508533385406825812@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Sep 2026 15:32:18 +0200
X-Gm-Features: AclHuK9G1LwY60nItqHgHRaQMXQToZBqCE9yJlUT8JrhRdwfeEvhupBd-SBJo6A
Message-ID: <CANn89iKmREFPZLDXUUG7SV3qSHvXPW40eo7qWNN_Tu46CofLzA@mail.gmail.com>
Subject: Re: [PATCH net] udp: restore hlist_nulls for primary and secondary
 hash tables
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, kuniyu@google.com, horms@kernel.org, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:59=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 2 =C2=B7 Low: 2

Thanks for the review, comments below.

> [Severity: Medium]
> The pre-image here was an unconditional head insert.  Is the new IPv6 plu=
s
> SO_REUSEPORT tail insert part of the hlist_nulls conversion?  The changel=
og
> only describes restoring hlist_nulls and adding the traversal restarts, s=
o
> this chain ordering change is not mentioned.

No, it is not, and it should not have been there.  It was an attempt to
make udp_lib_rehash() consistent with udp_lib_get_port(), but it is not
needed for the hlist_nulls conversion and does not belong in this patch.

v2 keeps the unconditional head insert.  The CONFIG_BASE_SMALL
misdelivery you describe is a consequence of this hunk and goes away
with it.

> [Severity: Medium]
> Can this tail insertion defeat the nulls-value check added elsewhere in t=
he
> patch?

Yes, and this is the better argument for dropping that hunk.

hlist_nulls_add_tail_rcu() sets n->next =3D last->next, that is the nulls
marker of the bucket itself, while hlist_nulls_add_head_rcu() sets
n->next =3D h->first.  Only the latter is compatible with the nulls
scheme: a reader parked on a node that leaves a bucket and comes back
must be sent to the head of the chain, not to its end marker.  With the
tail insert the reader stops with a matching nulls value, so the check
can not fire and the rest of the chain is silently skipped, exactly as
you describe.

v2 keeps head insertion at this site and says why.

Note I am keeping the tail insert in sk_nulls_add_node_rcu(): the
pre-image sk_add_node_rcu(), used by udp_lib_get_port(), already did
hlist_add_tail_rcu() for IPv6 SO_REUSEPORT sockets, see d894ba18d4e4
("soreuseport: fix ordering for mixed v4/v6 sockets").  udp_lib_get_port()
only inserts unhashed sockets, and for the same-bucket re-insert case it
behaves as before the conversion, since hlist_add_tail_rcu() left
n->next =3D NULL and readers stopped there as well.  No change in
behavior, so not something to address in a fix for net.

> [Severity: Low]
> This path now does an O(N) chain walk with softirqs disabled.

Goes away with the above.

> [Severity: High]
> Should this walk also validate the terminating nulls value?

I do not think so, and this is not a regression.

Before this patch the same loop walked a plain hlist.  A socket moved by
udp_lib_rehash() kept its ->next pointing into the new chain, so the
reader already wandered into the other bucket, stopped on that bucket's
NULL and missed the remaining listeners of the original chain, and the
hash2_any pass could already revisit sockets.  The conversion does not
make this worse, it only makes the condition detectable.

Detecting it does not help.  As you note, by the time we reach the end
of the chain skbs have been cloned and queued, so a "goto begin" restart
would deliver duplicates, which is worse than missing a listener during
a concurrent rehash.  Multicast delivery here is best effort.

v2 adds a comment at both mcast_deliver() sites to record this.

> For completeness, __udp4_lib_demux_lookup() and __udp6_lib_demux_lookup()
> were also converted to nulls iteration without the check.

These look at the first entry only and break out, and
inet_match()/inet6_match() validate the 4-tuple, so there is nothing to
restart.

> [Severity: Low]
> This isn't a bug, but .clang-format still lists only the old name in
> ForEachMacros:

Good catch, v2 renames the entry.

Thanks !

pw-bot: cr
