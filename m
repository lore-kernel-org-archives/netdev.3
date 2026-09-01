Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D34B2E8897
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 04:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788238114; cv=none; b=JyVydmGOSycPGPQnWu+YSFN7weuNX7iMSe83uS9qc7VBL8kpJ5wWgGosSRNPLw7iDrBId2xiESLvCpG6rPsBFspbPlLH7G23psqCVFOoRWMeBZP8a6NE12zaYt4qElsJWoH6FOSWwaFYG8oLsmpcXHJtAO0hb90QADuB4AoDbgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788238114; c=relaxed/simple;
	bh=C+0ddwuvO2vIogDhotUfHV8WF2M4ei1FdzwnctaAwRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMiJ0ZtC66eb0haR87Pfxs2ipPKP+IRYKBPCO/XXYV9rG6BY9p9/BJbnhdZGcdQJ//MQXRR6/9k5aO5/FahXE+fpCHt+fj8+CHRZOXhdEJVwA7FnicQwIy/mf1QOIJjLcHeAn+55FGciYB0gV8uEiA/OWxntyNzD6Nw3HBHfSpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=Y7kjr5zB; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="Y7kjr5zB"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8568e3ed034so401108b3a.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788238111; x=1788842911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pQihIClwMZKkNvnNiMJcB5e3740T0qh3xP69Rw/Yuao=;
        b=Y7kjr5zB+h2ayuFxKEfHN9hteaP2TIwlbOq4M06hUxyh7L9+KYq/Cz9y/3WvvMl2sm
         3y6i/bLDs6CFuyms8s+N6bZ8pu7Au2GBqJpW+Q+AyDTUPsJSqIc4R0+FwOoqNzU0cBxW
         a1sYopdAB8Cti4enyMSeoWMqQ0FnC5Df9tJdKnQQpKjvTWwS/ziwNG3NnEwFrtgavkve
         FO+3QFR9kppVOFiqm/XLmGr0n8zoFQ5iLnsPQPnSSFy44d+U7lAjTEFiU0vHDZYf6lYX
         cmXe/Ckig/a7TbbcJkgHVnJ75xnFvb2ZqBHIt5HyBt8KVplXBVJZfa1RC0YlT6rToyFy
         Kcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788238111; x=1788842911;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pQihIClwMZKkNvnNiMJcB5e3740T0qh3xP69Rw/Yuao=;
        b=J7RWhva7n55Sf43fJSSyU881+R+DbsllHxW2dLcWfPFgblN2/Ahp0C2se7PYP8rAhc
         A67bHntHtN0BeVeb5GYRWR/jFQaDq3HAfAlT7FXWEuebIc+JLI0cGq6Z//mENptOkGnV
         siiSkIduRq0FWBQ3L7j4UEQehlwW+3O10v9Re8ANYa3zRkgb9fhHiePYJGa6uYA3qJE7
         yNPV+BZAjs42mzIl9IS+Xgv09ESWh+FYltDbKuhWYkoayU1iPbOY6wQUWu2IY0B5FOIR
         POSR+R0g8mmGFU4MlIScQxp5GrAxznrnKwTTPpq3euuwZiSDS5krUHBVriSa4BGT9hR7
         nuyg==
X-Gm-Message-State: AFuF++mXeu1vkYvqqiHvWqjLiiNHOSLMIbl5Lz4UiyPuoWBlGWfySwi/
	wqk0OnUowI0AzAbPmMNYDIllu4HYasrRXLsqntooWbOpqJQGgABG3NN4yW5LL2SEhkRIUntzIKS
	WDCvJ
X-Gm-Gg: AR+sD13NZm2OJ5P9JS3rvAXKXJ3lt+Dib2vNc9SM5Qupwdzyz/LtknaC9TfqgC6x28/
	n28Qfqjy+ns2IAUB7o0WSSf3Na5Tb6BlkXkaNvYRQamwBjQqXheDkqub8k3lO7L68A2IzVR7Fky
	/31qyesGZUyCHab7UqSqAiU3ZSIoap++AuLNLP2H/QJ+lx+74ebyDEa4nhBVjAYfYtxLQak/zj6
	ODhvngjJ6RhIBHKpf+/pcJ8ILztnzKPuFuT/lPRanfXymceh93u2KUTo5Nu5Y/N146jJxMzXETk
	IPMBsDO2RIpkiGyh6OR8yfcGf7nGx1yycZNuIZhlV2t2MS8lMq92qyIQsVGRRa+ENxEhSWdFaIY
	UcwdCVu1iwfQG3SBVACgdClAFkPcuZ3/80qEqgnfAJSQvRWeAPoKEbYcxDVN4LsUsCX5W5F1/Rs
	6PrdqFFU5wiWxiwZOBTjFybs00aGIe7v7SO1DIry3L9mlL4ThG3DUKRet8zmXESLuf4CvrQk4Af
	iqTBjxhIXDCbJQYAoF5g3qztFIqaHs=
X-Received: by 2002:a05:6a00:9512:b0:848:2eac:bfb2 with SMTP id d2e1a72fcca58-8562ba7dbdcmr44318429b3a.13.1788238111439;
        Mon, 31 Aug 2026 21:48:31 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85be934a18csm419288b3a.51.2026.08.31.21.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 21:48:31 -0700 (PDT)
Date: Mon, 31 Aug 2026 21:48:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Alexander Zubkov <green@qrator.net>
Cc: netdev@vger.kernel.org, Petr Machata <me@pmachata.org>, Ido Schimmel
 <idosch@nvidia.com>
Subject: Re: [PATCH 1/2] ip: ipstats: Merge statistics split across several
 netlink messages
Message-ID: <20260831214815.49754d76@phoenix.local>
In-Reply-To: <20260830181949.1096-2-green@qrator.net>
References: <20260830181949.1096-1-green@qrator.net>
	<20260830181949.1096-2-green@qrator.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Aug 2026 20:19:48 +0200
Alexander Zubkov <green@qrator.net> wrote:

> A netlink dump can split the statistics of a single interface across
> several messages. When an attribute does not fit into the current skb,
> rtnl_fill_statsinfo() keeps the partial message, records how far it got
> in idxattr/prividx, and the dump is resumed at the same ifindex, with
> the remaining attributes emitted in the next message.
> 
> "ip stats show group offload subgroup l3_stats" requests both
> IFLA_OFFLOAD_XSTATS_HW_S_INFO and IFLA_OFFLOAD_XSTATS_L3_STATS, and
> rtnl_offload_xstats_fill() emits them one by one, so a dump over a
> sufficient number of netdevices regularly ends up cut in between the
> two. Each message is currently formatted on its own, which yields two
> bogus records instead of one, and, because ipstats_show_hw_stats() bails
> out when the HW_S_INFO attribute is missing, the counters carried by the
> second message are dropped:
> 
>     109: vlan859: group offload subgroup l3_stats on used on
> 
>     109: vlan859: group offload subgroup l3_stats
> 
> Postpone formatting until the whole object has been received: keep the
> message around, merge into it any immediately following message that
> carries the same ifindex, and format the result once a message for
> another ifindex arrives or the dump ends. At most one interface worth of
> statistics is buffered at a time.
> 
> Merging the two messages means merging the nests that were open when the
> first one was cut short and that got reopened in the second one. Netlink
> does not mark nests reliably here -- nla_nest_start_noflag() is used --
> so they are recognized by the message layout instead: a reopened nest
> appears exactly once in either message, and at the outer level is known
> to be a nest by ipstats_stat_ifla_max[]. That knowledge only reaches as
> deep as ipstats.c parses the message, so merging stops at the group
> nests and their contents are appended in the order they arrived, which
> is correct both for a deeper nest reopened between two of its children
> and for an array of same-type attributes, as bridge per-VLAN xstats are.
> 
> A layout that does not fit the above cannot be told apart from an array
> of same-type attributes, and reassembling it would corrupt the result.
> Such a message pair is refused with -EOPNOTSUPP and the two halves are
> formatted separately, as before this patch. Failures to allocate or to
> build the merged message are not papered over that way and terminate the
> dump.
> 
> Fixes: 54d82b0699a0 ("ip: Add a new family of commands, "stats"")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Alexander Zubkov <green@qrator.net>
> ---
>  ip/ipstats.c | 280 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 276 insertions(+), 4 deletions(-)
> 
> diff --git a/ip/ipstats.c b/ip/ipstats.c
> index 8a2ac85e..c531885f 100644
> --- a/ip/ipstats.c
> +++ b/ip/ipstats.c
> @@ -850,12 +850,225 @@ ipstats_show_one(int ifindex, struct ipstats_stat_enabled *enabled)
>  	return err;
>  }
>  
> -static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
> +/* A netlink dump can split the statistics of one interface across several
> + * messages: when an attribute does not fit into the current skb, the kernel
> + * ends the message and resumes the dump at the same ifindex, emitting the
> + * remaining attributes in the next message. See rtnl_fill_statsinfo() and
> + * rtnl_offload_xstats_fill() in the kernel.
> + *
> + * Reassembling the two messages means merging the nests that were open when
> + * the first message was cut short and got reopened in the second one. Netlink
> + * does not mark nests reliably -- nla_nest_start_noflag() is used here -- so
> + * they are recognized by the message layout instead: a nest that was reopened
> + * appears exactly once in either message, and, at the outer level, is known to
> + * be a nest by ipstats_stat_ifla_max[].
> + *
> + * That knowledge only reaches as deep as ipstats.c parses the message, so
> + * merging stops at the group nests, and their contents are appended in the
> + * order they arrived. Appending is the right thing to do whether a deeper nest
> + * was reopened between two of its children or the children are just an array
> + * of same-type attributes, as bridge per-VLAN xstats are. It does the wrong
> + * thing only if a kernel splits a nest that ipstats.c does not know how to
> + * show either, in which case the merge is not the first thing that needs
> + * updating.
> + */
> +

The patch makes sense but please stop with the AI text spew in comments and
commit message. This is garbage. If you insist on using AI to write stuff,
then tell it to be terse and succinct. We don't need three paragraphs here.
One sentence will do fine.

Try again
