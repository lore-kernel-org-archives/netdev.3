Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793289233;
	b=5QQiKStc68KlI4qZoLHbFyB3Yei7YZGQo0XcptEqvRLCRX3PsYs4tOC339R3mtRNqJlW
	 F8HvV1NcClKT2uoEzqf2E/ML5IyayA+/nEY4qleqfj+vLQDOppO3dQCEcNr7UX3LB8rLe
	 4xNbcAGIltHwNjK5SUjz8LTNfsXTzz1o3uQ06fXZGUtWbc9iGRB/DFTwpIScIY6pyYHnF
	 7pX9CzQLmCg/E5V9+DGSdfjJGeKXiYG96uAd+uaJq1i0ySvHR+cOkBq7Y8PwVchOg4D37
	 BOzbN5q2QkjepOMzFloKrAWwUuOEe8ji+wE1e2QQS/SI3B/YD/qSgPhL84reADWegmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cTVOu4c15J1856ItbAlmhTsLRjjX4BIL7cg31O9/lmM=;
	b=sYm8OzNTLBz+cfrdSWPS+f33Rs1LjsOYTMi4REuOSF1LRjOU9Yu64nHNBSMqS7rapfU5
	 xsOEzGzW3WpXvjKPf7JMMGqDGza4Z9Fsde9AoBhVP+//BUkbRJVcjR+j/IPR+PDL6zRO3
	 9jI8nLwfgYCJiL1BQ/WzBA0L12ezaUk0/qxfBMv9w44Lt+0G4ocXuHxH2a2gpB7G6RbzH
	 ZvwmeTKkDpvy62U+8t2Wc2EO66fCFjPQs6XcZFyNbWsLPNdbs/rn8b7ey7BqZQCbEmDzi
	 xX5VI3d6NV+f0inAM6yQpkxVYqCoS7+6QkwFYG6+wDIQX40h4aq60Npn4DcZV1anfGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uxiIybsT;
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B51606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 15:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49B51606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uxiIybsT
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so817277241.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793289232; x=1793894032; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cTVOu4c15J1856ItbAlmhTsLRjjX4BIL7cg31O9/lmM=;
        b=uxiIybsT3eFKXSM7jcIbSAlZoR3RVXHGbGvNa2gwyXM77xos206PLZlB1pbmBf+DHh
         pG3kGoXcdYgCt/F0qQ3WvYGkASVFA6Hhb+ybn8kusmldpLKp8jmExrnc51gBSo/CO6xc
         UkmtvxVjFBwzuTshN9wkQCaY8vsftzkJhZOWy2bCFF0Oipo9Gv3mdQpdXBNUpX4NNb3d
         NpDhNr1qvTYeN6bL0tMJtiFFC98L+RfYR49BewB0CR3L4/JGuNsOKoDRV4ST5JpqlnRh
         rlNvPotOw0YDzDbFltTuKObOfmKxiOhxzd5Z4+zu5RhTwCEh7BPc3t8NiveR99ePSsVG
         t1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793289232; x=1793894032;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cTVOu4c15J1856ItbAlmhTsLRjjX4BIL7cg31O9/lmM=;
        b=hsoJpIxC4Z6Y//752Txb1cZ/xdzj31lERYr9aBUr0I8+hx7dowkv7If03sP4LITwyj
         0RMEfSASA/UIdzFZ5JRaEc5tBjjcWnYV5vF+PrVZFizDbnnoRMjo0EWCtLy+2xdjBPgC
         r6d2VNoY5FnIBIdG6ppWqp0ahG50xaEm/XL1uHLe6dN0W2jc8LJj99hu4NLXSJjbmBjo
         JS5UzZQfkGVYhknKWImBV/5Bk7/tBCKDMERp/Z+lMPchesj46dnHHuuu9RwcgnTWcR2J
         INCsrM9L7dSvF1AM5C27T57c1wy5r8XNAu21P6lOXyTu25ElQmUNe6lvaZAwAs9pzCYx
         mONw==
X-Forwarded-Encrypted: i=1; AKwUvBwD21ZfD565ybmXIcf3QLt/pd6cKR3gbgpCZKfyj8kASQIyfAMZZLlZfFeK/SrHIVMl2txd77c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHhqKiFUs075WUQM3zU4KUSKCXfMZ+To1LjBBnPZlXGcQstvLD
	NJKxzNhJ3oWMYUHFS/1Z11X6YfIlt15qbYwOPH2lIIOheehw9V+meI0Y
X-Gm-Gg: AYBFou0v4VN0Btbg2eHYjKjEUl3U+4vlO/j3evbrI7KeHWs7PH2E09dP5ZUd9i4bKBz
	QV/zHAH1BJLBb5D9WvDLXthAbC1F1jl4LWkP8nBSTe1Mt4GZAB1fB+UoALkk1NaOe9MthDk1u0t
	VCitaRYB/onC5nQ9yowV5R6MjZB+bCTSvmWVTlqFr0a8bXoveCwH1jCsjxUEI1R0/o1cGnR+Pd4
	7dKbKllxJDXqskoIX/C55pha2toyElrJtAMA9xQxHIuDN8cTiZu1Ds/Eys+DRoB3hZehDHXmYob
	222SG7cfC8WXX535GTz08AL046D97tXlLE06ZReuCp9f4uvk6G3gKPyLYZqBZjer7jclLtZ4Ia6
	Y1lh1+DPpdFVIul609ABTOPBFum90HDy03N0nk5VWpOG0PLHxM+EYROuK7jxfz4hwcp+9PluGgX
	aBDXHRtPYC4PxPvQWYtaNdrLdpipsBxCgOCr8jvbdHezEE7Isu2Lo4LBAFgAxztkhfayJ45Ntdi
	Sw6of5lTwCmrdL8l3+CcPVtfMuoi7WRB/uEi4ed/GaoBiK7nY59538CHdzdzhC34PwG36+twn2N
	3X0uZ3Kd7LrxPEkytbGk9bYhDtIYTJf/KUYKDC24xtKNHyfPL5q2HMBMXzQ2JSConIdnWQMpbMG
	YA314R//Hx6qiUY9exUMf/H8rDcU6N2jPdw==
X-Received: by 2002:a05:6102:5244:b0:7c8:78bd:fd7a with SMTP id ada2fe7eead31-7d054298427mr897702137.25.1793289231938;
        Thu, 29 Oct 2026 08:53:51 -0700 (PDT)
Received: from [192.168.15.16] ([2804:1b3:a2c1:77a1:5cd:8fee:f3c:4da7])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9924f6c9c53sm42988241.8.2026.10.29.08.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 08:53:51 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Toms Atteka <cpp.code.lv@gmail.com>,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] openvswitch: advance by the real header length in
 get_ipv6_ext_hdrs()
Date: Thu, 29 Oct 2026 12:53:41 -0300
Message-ID: <179328922134.76862.10417963652853801970@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

get_ipv6_ext_hdrs() walks the IPv6 extension header chain to fill
key->ipv6.exthdrs, but advances to the next header with ipv6_optlen()
whatever the current header is.  That is only right for Hop-by-Hop,
Destination Options and Routing headers:

 - an Authentication Header is ((hdrlen + 2) << 2) bytes long
   (ipv6_authlen()), so with hdrlen = 4 the walk skips 40 bytes instead
   of 24 and reads the next "header" from the ICV and payload;

 - a Fragment header is always 8 bytes, and the byte read as hdrlen is
   its Reserved field, which the sender controls and receivers ignore,
   so a non-zero value makes the walk skip up to 2048 bytes and miss
   the headers that follow.

In both cases the OFPIEH12_* bits stored in key->ipv6.exthdrs depend on
bytes chosen by the sender rather than on the headers that are actually
present: payload bytes that look like another AH or a Hop-by-Hop header
add OFPIEH12_UNREP/OFPIEH12_UNSEQ, and real headers after a Fragment
header can go unreported.  Flows that match on OVS_KEY_ATTR_IPV6_EXTHDRS
then classify such packets wrongly.  There is no memory safety issue,
skb_header_pointer() bounds every read.

Advance by sizeof(struct frag_hdr) for Fragment headers and by
ipv6_authlen() for AH, as ipv6_find_hdr() does.

Fixes: 28a3f0601727 ("net: openvswitch: IPv6: Add IPv6 extension header support")
Link: https://lore.kernel.org/all/178905555085.219967.6617611783437228045@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
---
Found while going through the pre-existing issues the Sashiko review of
"openvswitch: fix wrong flag value in get_ipv6_ext_hdrs()" pointed out
(Link above); Eelco mentioned putting them on his todo list, and I did
not find a fix for this part in net, net-next or on the list.  Happy to
drop this if a fix is already in flight.

Tested by building get_ipv6_ext_hdrs() before and after this patch in a
userspace harness (skb_header_pointer() replaced by a bounds-checked
memcpy from a buffer) and feeding it crafted packets:

  AH(hdrlen=4) + DSTOPTS + TCP, payload mimicking AH at old offset
    before: AUTH DEST UNREP UNSEQ      after: AUTH DEST UNSEQ
  FRAG(Reserved=0xff) + DSTOPTS + ROUTING + TCP
    before: DEST FRAG UNSEQ            after: DEST FRAG ROUTER UNSEQ
  FRAG(Reserved=0) + ROUTING + TCP, HOP + DST + ROUTING + TCP
    unchanged

net/openvswitch/ builds cleanly with W=1 (arm64, net/main 94cea342e891).
I did not test it on a live datapath.

 net/openvswitch/flow.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 1c4f3a079..a1c60d2f5 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -372,8 +372,13 @@ static void get_ipv6_ext_hdrs(struct sk_buff *skb, struct ipv6hdr *nh,
 		hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
 		if (!hp)
 			break;
+		if (next_type == IPPROTO_FRAGMENT)
+			start += sizeof(struct frag_hdr);
+		else if (next_type == IPPROTO_AH)
+			start += ipv6_authlen(hp);
+		else
+			start += ipv6_optlen(hp);
 		next_type = hp->nexthdr;
-		start += ipv6_optlen(hp);
 	}
 }
 
-- 
2.39.5
