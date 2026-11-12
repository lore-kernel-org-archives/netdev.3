Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794469936;
	b=xa1Fo9n6m2FFwOT5Un/aPbxKteQBPpPo9F4m9hZMfxWGKjbu9jOG97AziWKcwdt5FKAm
	 necJUQXRfJVT6EVLCpbxpvGUabO4F9G7PbE86ml+gZJrjLTW+/WUXrmvCr17xJrTaHcyC
	 cdGGKocXOKedxl11JveRWqmTFQnoXkrPssFA62tjBoBPQfCN+dAer+/jyxLaEF14kc6YX
	 X1nG3xo1b+k4d4EvYAJgbLaR56K0GEphj7ojSwJx7JHhLRZ9GiJyM3nuGhyRdVig8fIWO
	 apFDNbXzBXmJMMXHgrg0LwSsK3WJyXm6xv9eO2yBpXVqD4T30Hb7nqJWuG0fu7IWP7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=K1dwa5SVcdVl9SxOaymeN7W3eK9N60eySET00G1LWEg=;
	b=v7NM1k5tnGZipYuCgCQIxWFGbde9wgB/ikJhzBpKhRP8iDN+PNQBbfxPSWdqGmtOuFQA
	 vJfoHmqPJxFNRgGqnidB1OgeLZBo42rqozc/LEbmfHgVMt919NeLR6FREcRsnoYsSi5v8
	 Czc/TP8grnxc1RNfMPMTzujKP4MjZmueL1FTIyEeWSmJ78GiuJiQ2ZD4m4x57R75z31QI
	 vSSiyi9OL05CTClCFwVxIIrR3FVLyCsLQQdv/7Bz6q/4HOAzaixZBDwoboodxwyhl/kFj
	 9yS4PmZXylaaiiHz8+FoOnNFSO9Dhe/An6dyaWgCpHxGzPyIqQM/wjjg36rPZlhpL/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=(null) smtp.mailfrom=iiitd.ac.in;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F9606A33A
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 07:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A64F9606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=iiitd.ac.in
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-37071c0f42aso6753601eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 23:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1794469929; x=1795074729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K1dwa5SVcdVl9SxOaymeN7W3eK9N60eySET00G1LWEg=;
        b=OJLwX4DxTV5jJ0LokAW/8DAlBK9Z2d425vsqFEPibaIjyk9CebKYJgtGxcjexcR7kg
         oaT33ouN1BFrspzSEwaU46N1CGtrkGExseCE5G/GQQ4xzoL/50rVtph268ArNf7yT+jy
         eQMTHRTHvI2R2JKlTkQv4NV5t3PRmj505oEvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794469929; x=1795074729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K1dwa5SVcdVl9SxOaymeN7W3eK9N60eySET00G1LWEg=;
        b=wKo9Jdb4AEpGVobCOzqRlYOJ4ZIIT3Z7xcK484hhMmtIZUIWEFbvMw13lp0t+2LnCs
         Rbz4MYNgL/A3HQFx1MG+TwXymXzHkUsQ3EAS3MGSZC3aPpkpvcbLCuj57TZSpJzkSkNM
         Z6M8iWkmCYjLdNj3G1PVNUiSfQujebYyR9xdoGALp9egav/cRWMxY0obxBNrRchYeyL7
         1kAh2xnXQFq5Mo1nve+dXpclAwZ7+Z/kjPQkfvzfr56+PT5/3Rn5JTBTZ78s/ZxEf4Q7
         PNkbtxJyK6iK7llMqsRv13TOo4tOyxWYhpLIsKTPAox9E+aYy7y06Fxb7cF6qkPdGiua
         GuNQ==
X-Forwarded-Encrypted: i=1; AL+hErESyYX78sKiyRlftkwvc8tGJhMgNLTQdR2sA/lBUUjAX9osC3fBKYbpOLyFoHuQLJqNyr6VOH4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VJsqFCNAl2PByOSKlM9d7O5RznOhnQZlPQP4zmREI0YD7bCHV
	Aul+amZrwE7rurvdj0fttyTUjnjFbwL+W5t7TsNCIz//NGb8jdOLYFkcrey9yVUUWSY=
X-Gm-Gg: AYBFou2WsXC4B/UDUVhkl2iM8bimb2sG9/7GB5mYGzX4d2B4xHfhmMnbnQK2P9lJd6e
	tHvRLnBQUSOZRK2HvdqJVNA3danfWYgzUnk2J2f4GP1Z3nPgC6ojpNXWfzTG5ytmkkel2GkphiA
	edBsR+8dYUEwiT+RZdd1MlwcBpXPIlI6G+kMPh08YVa41JNYoXfKhuec9XPp445Vfk1UmIwGBW0
	uV8tLfSeexb5q7d/IjUbioQ13t9B23QD85IKThWcsP5ds/PkgemK+1DKzaq3+MkRV2aOiuUwEpN
	am4aYIZRobD39FdThBnuK1k8822pL4sXXzarn3OFQgFHCXoN9KRBN1MX2mCe9zpr+qD0lOrIIYb
	b+jTbYsQIdRuXuTp7sQ/dF7BCA2wsFR0ohGzDANuQjsUA74u9FF8tfrLG1cT//fZ0HcU/Ni/RdA
	g/icQWuFMHN3PQzfQWSjKOPS3z1NZLRMYdWH2Qc7kVEwHBu+0FIWkkMJOA6Y/3wikLyFGFohZDI
	87NbW4eO5+mrGTsDw7uOrBJYCxt4CMGWBUmKIhb1NafBUGrXG3SF9bdqKPWh6ppXbHM/3BdTcoc
	lXKuL819MIZuRiopiKaFsLqe65tfj6/iAOd6M5lcRWDHKiXRviZI3RQmSauoWelywnyVK5vN3Dv
	zOC4In/+0KgtkAT/SiKyydyD6Om1FoPQSk4E5LzWOpHPVlcDrEfD+98ACpit8hmDM
X-Received: by 2002:a05:693c:20c5:20b0:35d:2633:ff79 with SMTP id 5a478bee46e88-37686e2ee12mr5321907eec.40.1794469928431;
        Wed, 11 Nov 2026 23:52:08 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bfb58dsm43586025eec.18.2026.11.11.23.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 23:52:06 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kapil Vaswani <kapil@presceralabs.ai>
Subject: [BUG] net/sched: act_csum: slab out-of-bounds read in csum_partial() from an unbounded IPv6 hop-by-hop jumbo payload length (seen on 7.3.1)
Date: Thu, 12 Nov 2026 13:21:59 +0530
Message-Id: <20261112075159.3552470-1-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jamal and Jiri,

We would like to report a bug in act_csum.

Summary
=======

Affected: net/main at a2fd526d6442 and mainline at 79eb6679ef6a, both of
which carry net/sched/act_csum.c byte-identical to the 7.3.1 tree this was
found on.  Unchanged since eb4d40654505, first released in v2.6.37.

Problem: tcf_csum_ipv6_hopopts() stores the IPv6 hop-by-hop jumbo payload
length without bounding it (act_csum.c:471). tcf_csum_ipv6() passes it on
as the extent of the packet, and csum_partial() then reads past the end of
the skb.

  BUG: KASAN: slab-out-of-bounds in csum_partial+0x103/0x1f0
       lib/checksum.c:119
  Read of size 4 at addr ffff88805fe8e9c0 by task syz-executor/9555
   tcf_csum_ipv6_udp -> tcf_csum_ipv6 -> tcf_csum_act -> tcf_classify
   -> tc_run -> __dev_queue_xmit -> ip6_output -> rawv6_send_hdrinc

The read is 0 bytes past a 704-byte skbuff_small_head object.  KASAN only
reports it; on a kernel without KASAN the read still happens.

Conditions: a clsact qdisc with a csum action carrying
TCA_CSUM_UPDATE_FLAG_UDPLITE, on an Ethernet-type device, with the packet
locally generated. CAP_NET_ADMIN in the network namespace, which
CONFIG_USER_NS makes reachable by an unprivileged user.

Reproducer: tested, not included here - see section 5.

Fix: attached as a separate patch, verified at runtime (section 7).

This bug was found with AI assistance.

1. Root cause
=============

tcf_csum_ipv6_hopopts() walks the hop-by-hop options:

  /* net/sched/act_csum.c */
		case IPV6_TLV_JUMBO:
			optlen = xh[off + 1] + 2;
			if (optlen != 6 || len < 6 || (off & 3) != 2)
				/* wrong jumbo option length/alignment */
				return 0;
			*pl = ntohl(*(__be32 *)(xh + off + 2));
			goto done;

All three conditions guard the option's own shape - its length and its
4-byte alignment. None of them guards its value, so *pl is unbounded:

  /* net/sched/act_csum.c, tcf_csum_ipv6() */
	pl = ntohs(ip6h->payload_len);
	...
		case NEXTHDR_HOP:
			...
			if ((nexthdr == NEXTHDR_HOP) &&
			    !(tcf_csum_ipv6_hopopts(ip6xh, ixhl, &pl)))
				goto fail;
	...
		case IPPROTO_UDPLITE:
			if (update_flags & TCA_CSUM_UPDATE_FLAG_UDPLITE)
				if (!tcf_csum_ipv6_udp(skb, hl,
						       pl + sizeof(*ip6h), 1))

Therefore a 32-bit value out of the packet arrives at the per-protocol
handler as ipl, the extent of the packet.


2. Why the two guards downstream do not prevent this
====================================================

Both checks were written for a length that is plausibly wrong, but do not
account for a value that is close to 2^32.

  /* tcf_csum_skb_nextlayer() */
	int ntkoff = skb_network_offset(skb);
	int hl = ihl + jhl;

	if (!pskb_may_pull(skb, ipl + ntkoff) || (ipl < hl) ||

"ipl + ntkoff" is unsigned int + int, computed modulo 2^32, so an ipl just
under 2^32 wraps to a small number and pskb_may_pull() succeeds having
pulled nothing.  "ipl < hl" is false precisely BECAUSE ipl is huge: it
exists to reject a packet too short for the next header and cannot reject
one claiming to be too long.

  /* tcf_csum_ipv6_udp(), UDP-Lite arm */
	ul = udp_get_len_short(udph);
	...
		else if ((ul >= sizeof(*udph)) && (ul <= ipl - ihl))
			skb->csum = csum_partial(udph, ul, 0);

"ul <= ipl - ihl" compares a 16-bit length from the packet against about
4.29e9, so every value of ul passes.

A jumbo length just below 2^32 therefore defeats all three tests at once.
ipl is that length plus sizeof(struct ipv6hdr), so ipl + ntkoff wraps and
pskb_may_pull() is asked for a small number of bytes and succeeds; ipl < hl
is false because ipl is huge; and ipl - ihl is also near 2^32, so any
16-bit ul satisfies ul <= ipl - ihl.  csum_partial() is then handed that ul
over a packet of a few dozen bytes.

The UDP-Lite scenario is the only reachable sink. csum_partial() takes a
signed length:

  /* lib/checksum.c */
  __wsum csum_partial(const void *buff, int len, __wsum wsum)
  ...
  static unsigned int do_csum(const unsigned char *buff, int len)
  {
	  ...
	  if (len <= 0)
		  goto out;

The ICMPv6, IGMP, TCP and SCTP handlers all pass "ipl - ihl" straight to
csum_partial().  With the ipl above that is 0xFFFFFFC2, which as an int is
-62, so do_csum() returns having read nothing.  Those handlers are therefore
protected by accident, not by a check.  The same applies to the UDP-Lite
"ul == 0" branch, which also passes ipl - ihl.

What makes the UDP-Lite arm different is that it passes ul, a separate
16-bit length taken from udph->len, which is positive and plausible.  The
comparison that should have bounded ul against the packet - "ul <= ipl -
ihl" - does not work for large ipl.  So the over-read is at most
65535 bytes, not 2^32, and it happens only here.

Plain UDP is not affected either: its branch requires ul == ipl - ihl
exactly, which a 16-bit ul cannot satisfy against a huge ipl.


3. KASAN report
===============

Linux 7.3.1, CONFIG_KASAN=y, CONFIG_KASAN_GENERIC=y, CONFIG_KASAN_OUTLINE=y,
CONFIG_KASAN_STACK=y, x86_64, under qemu.

net/sched/act_csum.c is byte-identical to net/main and mainline, and no .c
or .h file under net/sched is modified.  The one local change in the
subsystem is a line of compiler flags appended to net/sched/Makefile by our
coverage harness -

  subdir-ccflags-y += -fno-inline -fno-inline-functions \
                      -finstrument-functions-after-inlining \
                      -mllvm -sanitizer-coverage-prune-blocks=0

which is why the trace has real frames for functions that would normally be
inlined, and why one frame resolves to "act_csum.c:-1".  The flags change
inlining and coverage instrumentation, not semantics.

The line numbers can be checked against net/main at a2fd526d6442, where they
are the same lines: act_csum.c:549 is the tcf_csum_ipv6_udp() call in the
IPPROTO_UDPLITE arm, and act_csum.c:601 is the tcf_csum_ipv6() call in
tcf_csum_act().

  ==================================================================
  BUG: KASAN: slab-out-of-bounds in do_csum lib/checksum.c:64 [inline]
  BUG: KASAN: slab-out-of-bounds in csum_partial+0x103/0x1f0
       lib/checksum.c:119
  Read of size 4 at addr ffff88805fe8e9c0 by task syz-executor/9555

  CPU: 3 UID: 0 PID: 9555 Comm: syz-executor Not tainted 7.3.1 #2
        PREEMPT(full)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
  Call Trace:
   <TASK>
   kasan_report+0x147/0x180 mm/kasan/report.c:595
   do_csum lib/checksum.c:64 [inline]
   csum_partial+0x103/0x1f0 lib/checksum.c:119
   tcf_csum_ipv6_udp+0x19e/0x250 net/sched/act_csum.c:-1
   tcf_csum_ipv6+0x63c/0x780 net/sched/act_csum.c:549
   tcf_csum_act+0x34d/0x480 net/sched/act_csum.c:601
   tcf_action_exec+0x109/0x390 net/sched/act_api.c:1161
   basic_classify+0x11d/0x200 net/sched/cls_basic.c:54
   tcf_classify+0x13d/0x440 net/sched/cls_api.c:1875
   tc_run+0x31a/0x460 net/core/dev.c:4491
   sch_handle_egress net/core/dev.c:4625 [inline]
   __dev_queue_xmit+0x1a7e/0x2390 net/core/dev.c:4890
   ip6_output+0x280/0x400 net/ipv6/ip6_output.c:248
   rawv6_send_hdrinc+0xb90/0x1170 net/ipv6/raw.c:663
   rawv6_sendmsg+0x10d3/0x1260 net/ipv6/raw.c:908
   __x64_sys_sendto+0x76/0x90 net/socket.c:2284
   </TASK>

  The buggy address belongs to the object at ffff88805fe8e700
   which belongs to the cache skbuff_small_head of size 704
  The buggy address is located 0 bytes to the right of
   allocated 704-byte region [ffff88805fe8e700, ffff88805fe8e9c0)
  ==================================================================

The full report, and a second one for the variant in section 7, can be sent
on request.  KASAN reports and lets execution continue, so csum_partial()
carries on towards the length it was asked for; in our runs the VM
stopped answering shortly afterwards.

The task name is syz-executor because our harness runs the reproducer under
that name.


4. Impact
=========

Stating only what we verified, and our reading of
Documentation/process/threat-model.rst - please correct it:

  - The over-read is bounded by udph->len, so up to 65535 bytes, and it is
    attacker-chosen within that.  The run we measured started a few dozen
    bytes into a 704-byte skbuff_small_head object and asked for tens of
    kilobytes, so it ran well past the end - far enough to leave the
    object's pages, which makes an oops a plausible outcome on a kernel
    without KASAN.  We did not observe one: KASAN reported and the VM
    stopped responding.

  - Setting up the qdisc and the action needs CAP_NET_ADMIN, which an
    unprivileged user obtains in their own network namespace when
    CONFIG_USER_NS is set. As per threat-model.rst, network configuration
    inside a user namespace is itself "excess of initial privileges" and not
    a vulnerability; what we think crosses a boundary is that it lets an
    unprivileged user fault the kernel, which the same document lists as
    protection the kernel offers ("nor affect the system's availability").

  - csum_partial() returns a checksum of the out-of-bounds bytes and
    tcf_csum_ipv6_udp() writes it into udph->check, so 16 bits derived from
    adjacent memory leave the system. We are NOT claiming this as a
    disclosure vector: the bytes are not attacker-chosen and the result is
    a computed value, which threat-model.rst classes under "random
    information leaks".  We are mentioning it only because it means the
    packet is transmitted rather than dropped.

So we read this as a modest availability vulnerability, not a disclosure
one. We have not attempted an exploit beyond the faulting read.

5. Reproducer
=============

Tested, and deliberately not included. We are happy to send it to any
maintainer if required.

6. Suggested fix
================

Bound the length the way the kernel's two other readers of this option
already do - ipv6_hop_jumbo() in net/ipv6/exthdrs.c and
nf_ip6_check_hbh_len() in net/netfilter/utils.c.  Both apply the same three
tests, and act_csum does not apply any of them:

  /* net/netfilter/utils.c, nf_ip6_check_hbh_len() */
		if (nh[off + 1] != 4 || (off & 3) != 2)
			return -EBADMSG;
		pkt_len = ntohl(*(__be32 *)(nh + off + 2));
		if (pkt_len <= IPV6_MAXPLEN ||
		    ipv6_hdr(skb)->payload_len)
			return -EBADMSG;
		if (pkt_len > skb->len - sizeof(struct ipv6hdr))
			return -EBADMSG;

The one adjustment needed is the network offset: those two run where
skb->data is at the network header, while act_csum runs at tc egress where
skb_network_offset() is 14, so "skb->len - sizeof(struct ipv6hdr)" would be
14 bytes too generous there.

The patch is sent separately, against net/main at a2fd526d6442.  It also
gives tcf_csum_ipv6_hopopts() the skb it needs to do this.  Once *pl is
bounded, ipl cannot exceed skb->len, the sum in tcf_csum_skb_nextlayer() no
longer wraps, and the UDP-Lite comparison is a real bound again - so the two
guards in section 2 start working rather than being replaced.

Returning 0, i.e. dropping the packet, follows what the function already
does for a malformed jumbo option two lines above.

7. What was and was not checked
===============================

We verified this bug at runtime. Same .config and same VM image before and
after, with only net/sched/act_csum.o rebuilt and the kernel relinked -
build #2 unpatched, build #3 patched:

Four runs:

  - the reproducer faults before the patch and runs to completion after it;
  - a variant that trips the RFC 2675 test rather than the length test
    behaves the same way;
  - a control carrying an ordinary hop-by-hop option and an in-range
    UDP-Lite length still has its checksum computed on the patched kernel.
    That control was not run before the patch; what it shows is that the
    patch did not break the path.

  before, reproducer: Read of size 4 at addr ffff88805fe8e9c0, task 9555
  before, variant:    Read of size 4 at addr ffff888024cb6340, task 11851

The "after" runs are not silent passes: every setup step reported success
and every send was accepted, so the packets do travel the egress path and
the action simply refuses the length.
The variant has a non-zero payload_len, which the patch rejects on the RFC
2675 test rather than the length test.  The control is the same program with
the jumbo option replaced by a PadN and a UDP-Lite length of 8, inside the
packet; it still has its checksum computed on the patched kernel, so
ordinary hop-by-hop options and the UDP-Lite path are unaffected.

By reading the source, not by test: a legitimate jumbogram is still
accepted, exactly. Linux has no transmit
path for one: tree-wide, IPV6_TLV_JUMBO appears only in
include/uapi/linux/in6.h, net/ipv6/exthdrs.c, net/netfilter/utils.c and
net/sched/act_csum.c, and IP6SKB_JUMBOGRAM is set in exactly one place,
exthdrs.c:1024 in the receive validator.  So the only legitimate jumbogram
this action can see is a received one, and by then ipv6_hop_jumbo() has
already done

  /* net/ipv6/exthdrs.c:1021 */
  if (pskb_trim_rcsum(skb, pkt_len + sizeof(struct ipv6hdr)))

i.e. trimmed the skb to exactly pkt_len + 40.  At tc egress avail is then
pkt_len + 40 and the new test reads "pkt_len > pkt_len", which is false:
accepted, at the boundary, with no margin lost.  At tc ingress the option
has not been validated yet - sch_handle_ingress() runs in
__netif_receive_skb_core(), before ipv6_rcv() - and skb_network_offset() is
0 there, so avail is skb->len and the test accepts whenever the frame really
carried the bytes.

Also by reading, not by test: the unsigned wrap becomes unreachable, so
the patch fixes it rather than working around it.  pl is assigned in
exactly two places in the file:

  act_csum.c:506   pl = ntohs(ip6h->payload_len);          /* 16-bit */
  act_csum.c:471   *pl = ntohl(*(__be32 *)(xh + off + 2)); /* 32-bit */

every handler is called with "pl + sizeof(*ip6h)", and the IPv4 side passes
ntohs(iph->tot_len) throughout.  The jumbo option is therefore the only way
a value wider than 16 bits reaches tcf_csum_skb_nextlayer(); with it
bounded, ipl cannot exceed 65575 and "ipl + ntkoff" cannot wrap.  We left
that helper alone deliberately rather than for minimality.

The other sinks were tested and do NOT fault. We first assumed
tcf_csum_ipv6_icmp() was reachable the same way, since it passes ipl - ihl
with no length check at all. It is not: the same packet with the hop-by-hop
nexthdr set to IPPROTO_ICMPV6 and the action carrying
TCA_CSUM_UPDATE_FLAG_ICMP ran to completion with no report, and a single run
with both flags set on one action sent the ICMPv6 packet first, survived it,
and only then produced the KASAN report from the UDP-Lite packet.  The
signed-length argument in section 2 is the explanation, and it is why we
have left those handlers out of the impact claim.

The fix is still upstream of all of them, which we think is the right place
for it: it stops a packet-supplied 32-bit value from becoming ipl at all,
rather than relying on each handler's length ending up negative.

Thanks,
Piyus Kedia
Kapil Vaswani
