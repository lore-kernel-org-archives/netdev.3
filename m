Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59572530E0E
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871715; cv=none; b=K9o9fTrz8auF3TW1ivmeLvOHp8Quz6bfPoTSSbSDJPPiG11r2Mt2DiAytnM+5WRrQ/IP/KJ+tUjKo7ucQpwBhQNrIGWRQh43hsVSkbxDAaKf9ELKwMb9kH9Zp1AjgGJABujtnqLTBfB8mzmpVsakaeDw1Wi/3VMEPDyTFFH2WxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871715; c=relaxed/simple;
	bh=cbazR0qJRYQukJ3pQKOnTVDmkzWDjUTd/LDwEiHact4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUGngppMh6EVyYxy5KiXy43gDraUE2wA+0q98iI/sMJiGj+SL6bjp4zatjouKDXsn+gikZ6asDXK1KirvRZ7ZVD+gPT5Iy4hqghE3p5S8A4CxCP8+Etx6J71pe4898QNcxKhnoI7EHKNQJwenpW+TMSLu6JE4kPh6tSO1VubNZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XI/2tzwF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHI0pGjv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XI/2tzwF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHI0pGjv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788871712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KApZ8FbpgYtgMnS+YEpWDi7dPTUF4xM9izXgUjH2PZU=;
	b=XI/2tzwFZQzrkzhDSSKod0rCTQq/OsUBIiAXLnov/x/CGO9t6kZswEkz9zQaW9O+dntxCg
	M/zee/PF+9saMaXCtl8BCgnK/6hOar5NOVrNVYV6KluZcYr91eDDaAF/KTHqcKsG3U9SBC
	Qr3+C9maaCZlDGSInf/ZsZ9BQeggx5U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-84d24f4HOGissX6_Up3brA-1; Tue, 08 Sep 2026 08:48:30 -0400
X-MC-Unique: 84d24f4HOGissX6_Up3brA-1
X-Mimecast-MFC-AGG-ID: 84d24f4HOGissX6_Up3brA_1788871710
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cd83ca361so51407805e9.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 05:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788871709; x=1789476509; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KApZ8FbpgYtgMnS+YEpWDi7dPTUF4xM9izXgUjH2PZU=;
        b=SHI0pGjv70L9gpU7lJa9XswtbNh6W3O+9FCXRNHtUveHCDP0czq24vMwOCB60M0i5u
         LSpWWZsmrZ7urnH5ncJERSqE4uP1iFpHbT6Sz5MrNoFlkFuZOqYn77n1ASE0iVqyNdZC
         HLEKwCYKxadhopmYzTiBrLPNgZnl8SE2Sb0UGtuO679yTULjPlSp96aeWkyFGNIdKBCA
         SN0vCb62SwDiKh0vmdpK0CyX4/AyjdZP/2t0JtQMBvolREsG9ziAJk5DO5wpf5XKmU7U
         RjgPghatDu0j+oSKf39liD87N1fC0QMkE0aFmMJv9IMj8tJyoFXQyPyg7UXmjzlRop0Q
         SMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788871709; x=1789476509;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KApZ8FbpgYtgMnS+YEpWDi7dPTUF4xM9izXgUjH2PZU=;
        b=XncmkkbjFZY0j4ATBAFkQGMCIl2WN4dyKsP/JoCKzcPI19YdaKX8h1shblwRWjYqUm
         DaNnRCQDdjt9rxzH7ECPSklDxdSgenOZ7f60cOQZewIqqmaX3+i+9HevbTwHxGw0/396
         eICjOoS6GubacQBAq+psTA7dTTuExUd4hS/Va4nUTsItc5SVYk1VuROtsEG9cJTuKDzc
         BNsKBbSQPONg/2/YPDw8T5IuisgTwT2sIvYLD3HLT1XdFJMrTgQi/BTtGmqKDTbJg6S2
         hgBztaOxJ7UK29bB1BPZkO5I1BocOMp9NlHxscc5qqguiDS/fMV1DTHhNLlDoo/ZRpN1
         /ZqQ==
X-Gm-Message-State: AFuF++lmrdMOBZ3imYQ7NFj/qEGwphWUiwma1Lr9eKGohgLjWdDvhpg1
	4crOp67V1ZD2fSUJpp/Uso8v9ifPfmP+YRh0Rq7SoFSfLesg59kMLjKRS7UOXBUjGPr9+/ba8zJ
	KdUqnHombPMYQAP0mY3nSB/o/ZIxCx2F+oITZ/nH4WCH78C/pwUoZG3BLNA==
X-Gm-Gg: AYBFou0kfdCYltCU/LETDgW/F99++b5sqdApBd5Hlg7glVFk/4q/cmUzuoHGj4Eyi+l
	7uhq4jX90p50EMj58+4vQoJObQdmuOXocewjvzmgFAv0fMGLoycWivIvuMV+Y+JKtQQuNsjmsAi
	f8J7EOLam7GdsC5PQENuQcOgp7xalMtV+bu0Cihn2buyqZvWez7yiqeGWAJSj9cBprakBHUQaVL
	uYl8ilsKYnd9YadkcjntHcn4sv7ikDVUUTEma+OK15vxh6ge5ocHReffh6xOod5kDOTHpl0tw9i
	WkQX4QibXjohM2rd0AZhfNe0rM0sKJ1EYiW/Ddyb2QzO92pk2l5LGp+zSwBAmwCnVVdulC6R537
	2r+pvfRysgJTRkUGV9aY28AnSxuXh+k057wrSUI279LaP1+HKlBlw
X-Received: by 2002:a05:600c:3e06:b0:49c:fc6c:be1b with SMTP id 5b1f17b1804b1-49cfc6cc0e9mr232612955e9.33.1788871709444;
        Tue, 08 Sep 2026 05:48:29 -0700 (PDT)
X-Received: by 2002:a05:600c:3e06:b0:49c:fc6c:be1b with SMTP id 5b1f17b1804b1-49cfc6cc0e9mr232612365e9.33.1788871708888;
        Tue, 08 Sep 2026 05:48:28 -0700 (PDT)
Received: from [100.90.169.165] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d07a23e85sm276626105e9.5.2026.09.08.05.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 05:48:28 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, cpp.code.lv@gmail.com
Subject: Re: [PATCH net] openvswitch: fix wrong flag value in
 get_ipv6_ext_hdrs()
Date: Tue, 08 Sep 2026 14:48:24 +0200
X-Mailer: MailMate (3.0r7030)
Message-ID: <9DBB98B4-08EA-4D7B-BC69-AC6B9C2BBE09@redhat.com>
In-Reply-To: <178885567772.219967.14568180746659022844@kernel.org>
References:
 <d42d6f04596dacab6cabfb1f06aaf4bd53394d3d.1788423539.git.echaudro@redhat.com>
 <178885567772.219967.14568180746659022844@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow



On 8 Sep 2026, at 10:21, netdev-bot+sashiko@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 (2) =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> - [Medium] Undisclosed second behavioural change in the IPPROTO_AH arm =
of
>   get_ipv6_ext_hdrs() (net/openvswitch/flow.c:299-309).

For this I sent a new revision with an updated commit message.

> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the `case
>   IPPROTO_ESP:` arm of get_ipv6_ext_hdrs()=E2=80=A6
> - [High] This problem wasn't introduced by this patch, but
>   get_ipv6_ext_hdrs() advances the parse offset with `start +=3D=E2=80=A6=


I'll add an item to my todo list, to take a look at those at a later time=
=2E

> --
>
> openvswitch: fix wrong flag value in get_ipv6_ext_hdrs()
>
> The ESP and AH arms of get_ipv6_ext_hdrs() masked out the numeric const=
ant
> IPPROTO_FRAGMENT instead of the OFPIEH12_FRAG bit when deciding whether=
 the
> extension headers seen so far are out of order.  Both masks are changed=
 to
> use OFPIEH12_FRAG.
>
> A few questions below about the two hunks and the surrounding parser.
>
>> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
>> index 46c1d66aad8c..868d9fdf3afd 100644
>> --- a/net/openvswitch/flow.c
>> +++ b/net/openvswitch/flow.c
>> @@ -288,7 +288,7 @@ static void get_ipv6_ext_hdrs(struct sk_buff *skb,=
 struct ipv6hdr *nh,
>>  			if (*ext_hdrs & OFPIEH12_ESP)
>>  				*ext_hdrs |=3D OFPIEH12_UNREP;
>>  			if ((*ext_hdrs & ~(OFPIEH12_HOP | OFPIEH12_DEST |
>> -					   OFPIEH12_ROUTER | IPPROTO_FRAGMENT |
>> +					   OFPIEH12_ROUTER | OFPIEH12_FRAG |
>>  					   OFPIEH12_AUTH | OFPIEH12_UNREP)) ||
>>  			    dest_options_header_count >=3D 2) {
>>  				*ext_hdrs |=3D OFPIEH12_UNSEQ;
>
> [Severity: High]
> This isn't a bug introduced by this patch, but is the "case IPPROTO_ESP=
:"
> arm being fixed here reachable at all?
>
> The parse loop in get_ipv6_ext_hdrs() is gated on:
>
> 	while (ipv6_ext_hdr(next_type)) {
>
> and ipv6_ext_hdr() in net/ipv6/exthdrs_core.c only accepts:
>
> 	return   (nexthdr =3D=3D NEXTHDR_HOP)	||
> 		 (nexthdr =3D=3D NEXTHDR_ROUTING)	||
> 		 (nexthdr =3D=3D NEXTHDR_FRAGMENT)	||
> 		 (nexthdr =3D=3D NEXTHDR_AUTH)	||
> 		 (nexthdr =3D=3D NEXTHDR_NONE)	||
> 		 (nexthdr =3D=3D NEXTHDR_DEST);
>
> NEXTHDR_ESP (50) is not in that list, so when the header walk reaches a=
n
> ESP header the loop exits before the switch is entered.
>
> Does that mean OFPIEH12_ESP is never OR-ed into key->ipv6.exthdrs, and
> therefore the bit exported to userspace through OVS_KEY_ATTR_IPV6_EXTHD=
RS
> (struct ovs_key_ipv6_exthdrs.hdrs) is always zero, so a flow matching
> OFPIEH12_ESP=3D1 can never match?
>
> If so, the ESP repeat test above, and the OFPIEH12_ESP term in the seco=
nd
> Destination Options mask, would also be dead, and the kernel-doc for
> get_ipv6_ext_hdrs() which lists the "Encapsulating Security Payload hea=
der"
> in the recommended ordering would describe behaviour the code cannot
> produce.  Would handling ESP as an explicitly admitted terminal header,=

> rather than relying on the generic ipv6_ext_hdr() gate, be the right
> direction here?
>
>> @@ -301,7 +301,7 @@ static void get_ipv6_ext_hdrs(struct sk_buff *skb,=
 struct ipv6hdr *nh,
>>  				*ext_hdrs |=3D OFPIEH12_UNREP;
>>  			if ((*ext_hdrs &
>>  			     ~(OFPIEH12_HOP | OFPIEH12_DEST | OFPIEH12_ROUTER |
>> -			       IPPROTO_FRAGMENT | OFPIEH12_UNREP)) ||
>> +			       OFPIEH12_FRAG | OFPIEH12_UNREP)) ||
>>  			    dest_options_header_count >=3D 2) {
>>  				*ext_hdrs |=3D OFPIEH12_UNSEQ;
>>  			}
>
> [Severity: Medium]
> Does this hunk also change the reported flags for packets carrying two
> Authentication Headers?
>
>> From net/openvswitch/flow.h:
>
> 	OFPIEH12_ESP    =3D 1 << 1,
> 	OFPIEH12_AUTH   =3D 1 << 2,
> 	OFPIEH12_DEST   =3D 1 << 3,
> 	OFPIEH12_FRAG   =3D 1 << 4,
> 	OFPIEH12_ROUTER =3D 1 << 5,
>
> IPPROTO_FRAGMENT is 44, which is 32 | 8 | 4, i.e. OFPIEH12_ROUTER |
> OFPIEH12_DEST | OFPIEH12_AUTH.  So the old mask here happened to whitel=
ist
> OFPIEH12_AUTH as well, while the new mask (HOP | DEST | ROUTER | FRAG |=

> UNREP) does not.
>
> A packet with two AH headers previously got only OFPIEH12_UNREP set, an=
d
> now gets OFPIEH12_UNSEQ in addition, which changes the userspace-visibl=
e
> OVS_KEY_ATTR_IPV6_EXTHDRS value.  The new behaviour matches the ESP arm=
,
> which already sets UNSEQ on a repeat, so it may well be intended, but s=
ince
> this carries a Fixes: tag and is a stable candidate, could the commit
> message mention this second change instead of only the fragment header
> predecessor case?
>
> [Severity: High]
> This is a pre-existing issue, but the AH ordering verdict computed here=

> depends on the chain walk that follows it being correct, and the tail o=
f the
> loop in get_ipv6_ext_hdrs() advances with:
>
> 	hp =3D skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
> 	if (!hp)
> 		break;
> 	next_type =3D hp->nexthdr;
> 	start +=3D ipv6_optlen(hp);
>
> Is ipv6_optlen() correct for an Authentication Header?  include/linux/i=
pv6.h
> has:
>
> 	#define ipv6_optlen(p)  (((p)->hdrlen+1) << 3)
> 	#define ipv6_authlen(p) (((p)->hdrlen+2) << 2)
>
> and ipv6_skip_exthdr() in net/ipv6/exthdrs_core.c picks the latter:
>
> 	} else if (nexthdr =3D=3D NEXTHDR_AUTH)
> 		hdrlen =3D ipv6_authlen(hp);
> 	else
> 		hdrlen =3D ipv6_optlen(hp);
>
> For a common AH with a 96-bit ICV (hdrlen =3D=3D 4) this walker advance=
s 40
> bytes instead of 24, so the next skb_header_pointer() reads ICV or payl=
oad
> bytes chosen by the sender.
>
> That value becomes next_type and drives all further advancement.  Can a=

> crafted AH packet therefore hide real headers that follow the AH (a sec=
ond
> Destination Options, Fragment, ESP), or fabricate OFPIEH12_FRAG /
> OFPIEH12_ROUTER / OFPIEH12_DEST / OFPIEH12_UNSEQ / OFPIEH12_UNREP bits =
out
> of payload data, letting flows keyed on the extension-header pseudo-fie=
ld be
> evaded?
>
> Should this use ipv6_authlen() when next_type is IPPROTO_AH, the way th=
e
> core stack does?
>
> -- =

> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/d42d6f04596dacab6cabfb1f06aaf4bd53394d3d.1788423539.git.echaudro%40=
redhat.com

