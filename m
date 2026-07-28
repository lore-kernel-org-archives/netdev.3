Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBC330D3ED
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274619; cv=none; b=uR89q/V1jBh2oGRHU/aIevpw3TB8BtrfWHMZBFyF5SwwOTYPxXizw7HujhOLBwYnKnRFyLfYTgnzhIgWVBl/xI5N4/g9A0TU+Die7gha4wYzY58peA7l17tbYii/vFc78oe+tNq19wrAJuDX0vxBKlucvr8Rki9YXcVomn/50xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274619; c=relaxed/simple;
	bh=f+smR8CtgxCi8pwiGIaizIzqp+MUoFL4trMSghAw17s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIIVsUFilNuqGS18X/GePNLRSsJAaos8yWM4rEMh23QjzyL5w50fyj/ssytn6CxBYU19LsynuSlZ95151eNtcwUY8/Bl6CmJAcMAkA47OLzcnY8Y4jvoV7CL4dAIKmHN+jrqwWFuZp4casozAlwL2Iz28nzI5qYrMd0aX+5+YEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=OMznhN3t; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="OMznhN3t"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caea3f742bso4657185ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 14:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785274617; x=1785879417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I1QCOULX9Dimh1CgJcG7tE2hxkESQrGt9M4dXay23O0=;
        b=OMznhN3tRurETOP8aOSXTZdT5fCn20528Nsm7oECBKf3Pk7f80SsVuKZk4MIonIThw
         Qm2lpbfcCFmgwr6EtOx7tAsZkbBIVbfkUj76+MNAZijaHDdJyX8IngiKmtnd8KvxzB35
         mWYjo/HOpIGrZXmBXlJERikdsOoMq4sFFlfb8FfdY3CjBlx+9IJR+ahRscCFzZaiyRuM
         2KVNfs9bOpAK7YPYGCDto6eGfbK/4aEJtEZMMWveHK2Fq8qoxW1lAo/nm0Jbiuv8qV0/
         +Z6SO6czQppkcXeUXVGnKbcXEGI9xdLKxzb/Tq99FrcPM66ZvHrhxeKK6uJvjB/XbuwH
         zbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274617; x=1785879417;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I1QCOULX9Dimh1CgJcG7tE2hxkESQrGt9M4dXay23O0=;
        b=ZPElviUMyBP+eT+AlAle1l3YVPnnC+zRl3X5Wrv/WqQiY4Whueh5PW/g3qXF8ANkyB
         WCxcB7AfDgbWw27RpF24p7LvobSl5teQ5zjmdLuBsIjMd4N4vO7gCtoppCuWjibeMvBC
         V7CJK9Ti9JhWb3Mljnhsh9pw1mXRk6L9hSrHTCyR38CIfYOuElzSTZjsZEqIBnKcXzlC
         DK5X4md8xuvPTXCsw6Eu32mh1sKANNCyALiddcHehQx/q66hZBqqb1jN64zjbQRMx/Bt
         Zv4lKPXtBpvELW/rv6dWrqy2AmMSH33huZwrH3/WH60jBYxwt6Fp2h20ZTgApHM2+8RH
         SMAA==
X-Gm-Message-State: AOJu0Yxvd3xyFf0F8/uEu+HaJyTtQ2jW+KXkJ7jfgkjaq0k0JJCB+6i7
	X/zG2biXzTwpdISiDjE5d36+0xxduYEjev9kRMzn/rdU3oX9tBUXdudRODPYD3RsywI=
X-Gm-Gg: AR+sD11AsXL+ZLOmtQdp5uY7lny10kBBzmXDNm+GQ9XgScw2w0MzGVvsLr+SbM1vZRO
	rPo7pcJInR9jRnl2gnQsc7aU2xFbYu9IkENRnvmJQ3u4bptCW0hJucrkplb16hXKC37ll21PS1l
	untyCvUaO0TT41DMZGmCbJf3upCW9U8BiykSzfKvJHVu+DpYMWgA6cRpYH9JDyeKeRX67nkNh0y
	fofNuggp2RBdV79+PwDwZ9MNuvObVkhA2y4N2brlEB2/qjYsXLKa782xBz6vDY6pxOp60W7kRh6
	mdW16nPqGQzp6CyLt6q+rnB0ZBpkzx28HqIqYqPnJKFv68mh1WQa/ZI0QbZPO0O0cZPWfVyL5Jf
	KbOYDO1VCq4DYqlX+UipUHm6wJE/fEzGXn0pOnTcRZT8mPjnwXJ/E10Yh8Umd43PaSq6wsYGZXB
	cJ3Xhbv8CU4tYXkFtw8aTxpmNdwQFhX7Fcdds1wd0NcjXWr04CmUEEP4srYZN+sm6cGEWIwIkbS
	li6eX0dVIEVfASBAsqwy4IWRZGw8Q==
X-Received: by 2002:a17:902:ccc8:b0:2ca:ef16:8e8 with SMTP id d9443c01a7336-2d015d115cfmr46678215ad.29.1785274616651;
        Tue, 28 Jul 2026 14:36:56 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b125bbsm2380576eec.5.2026.07.28.14.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:36:56 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:36:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: John McAndrew <jmcandrew.nc@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Vulnerability Report: iproute2-6.19.0 Stack Buffer Overflow in
 print_queuelen (CWE-120)
Message-ID: <20260728143652.5a1cb187@phoenix.local>
In-Reply-To: <CADCQVCg_ppRbJfmE5QDS0kDwwfMLGKDn7q8V+rbs0_=HCmbbsg@mail.gmail.com>
References: <CADCQVCg_ppRbJfmE5QDS0kDwwfMLGKDn7q8V+rbs0_=HCmbbsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jul 2026 16:03:16 -0400
John McAndrew <jmcandrew.nc@gmail.com> wrote:

> Dear iproute2 Maintainers,
>=20
> I have discovered a critical stack buffer overflow vulnerability in
> iproute2 version 6.19.0
> in the print_queuelen() function (ip/ipaddress.c:173).
>=20
> *VULNERABILITY SUMMARY*
>=20
> Type:              Stack Buffer Overflow (CWE-120)
> Affected Component: iproute2
> Affected Version:  6.19.0
> Vulnerability ID:  CVE-PENDING
> Severity:          HIGH/CRITICAL
> CVSS Score:        7.5 - 8.8
> Location:          ip/ipaddress.c, line 173
> Function:          print_queuelen()
>=20
>=20
> *DETAILED DESCRIPTION*
>=20
> The print_queuelen() function contains a critical vulnerability where
> untrusted
> kernel-supplied netlink data is copied directly into a fixed-size stack
> buffer
> without any bounds checking.
>=20
> Vulnerable Code Location: ip/ipaddress.c:173
>=20
>     static void print_queuelen(FILE *f, struct rtattr *tb[IFLA_MAX + 1])
>     {
>         int qlen;
>         if (tb[IFLA_TXQLEN])
>             qlen =3D rta_getattr_u32(tb[IFLA_TXQLEN]);
>         else {
>             struct ifreq ifr =3D {};
>             int s =3D socket(AF_INET, SOCK_STREAM, 0);
>             if (s < 0)
>                 return;
>             strcpy(ifr.ifr_name, rta_getattr_str(tb[IFLA_IFNAME]));  // =
=E2=86=90
> VULNERABLE LINE
>             if (ioctl(s, SIOCGIFTXQLEN, &ifr) < 0) {
>                 fprintf(stderr, "ioctl(SIOCGIFTXQLEN) failed: %s\n",
> strerror(errno));
>                 close(s);
>                 return;
>             }
>         }
>     }
>=20
>=20
> *VULNERABILITY ANALYSIS*
>=20
> The Vulnerability:
>   =E2=80=A2 Buffer: ifr.ifr_name is char[IFNAMSIZ] =3D char[16] (fixed si=
ze,
> stack-allocated)
>   =E2=80=A2 Copy Function: strcpy() - DOES NOT CHECK LENGTH
>   =E2=80=A2 Source: rta_getattr_str(tb[IFLA_IFNAME]) - untrusted kernel n=
etlink data
>   =E2=80=A2 Result: If IFLA_IFNAME > 15 bytes =E2=86=92 STACK BUFFER OVER=
FLOW
>=20
> Attack Vector:
>   1. Attacker crafts malformed RTM_NEWLINK netlink message
>   2. Sets IFLA_IFNAME attribute to string > 15 bytes (e.g., 100 bytes)
>   3. Sends message to kernel (netlink socket)
>   4. User runs: ip addr show (or similar command)
>   5. iproute2 processes message, calls print_queuelen()
>   6. strcpy() overflows 16-byte buffer
>   7. Stack memory corrupted: return addresses, saved registers, etc.
>   8. Attacker gains code execution
>=20
> Impact:
>   =E2=80=A2 Local privilege escalation
>   =E2=80=A2 Arbitrary code execution
>   =E2=80=A2 Denial of service via crash
>   =E2=80=A2 Information disclosure from stack memory
>=20
>=20
> *PROOF OF CONCEPT*
>=20
> 1. CODE ANALYSIS PROOF:
>    =E2=9C=93 Vulnerable function exists at ip/ipaddress.c:173
>    =E2=9C=93 No input validation before strcpy()
>    =E2=9C=93 Buffer is fixed 16 bytes (IFNAMSIZ)
>    =E2=9C=93 Source is untrusted netlink data
>=20
> 2. COMPILATION PROOF:
>    =E2=9C=93 Compiled iproute2-6.19.0 with AddressSanitizer
>    =E2=9C=93 Binary: ip_asan_compiled (attached)
>    =E2=9C=93 Compilation flags: -fsanitize=3Daddress -fsanitize=3Dundefin=
ed -g -O1
>    =E2=9C=93 Test output shows ASAN is active and monitoring memory
>=20
> 3. TRIGGER PROOF:
>    =E2=9C=93 Created malicious RTM_NEWLINK netlink message (140 bytes)
>    =E2=9C=93 IFLA_IFNAME attribute set to 100 bytes (triggers overflow)
>    =E2=9C=93 Successfully sent message to kernel via netlink socket
>    =E2=9C=93 Binary executes with memory monitoring active
>=20
>    Test Output:
>    $ sudo python3 simple_trigger.py
>    [=E2=9C=93] Created message with 100-byte IFLA_IFNAME
>    [=E2=9C=93] Sent 140 bytes to kernel
>=20
> 4. ASAN MONITORING PROOF:
>    $ ./ip_asan_compiled -V
>    =3D=3D2583902=3D=3DASan runtime does not come first in initial library=
 list;
>    you should either link runtime to your application or manually preload
> it with LD_PRELOAD.
>=20
>    This message confirms AddressSanitizer is linked and active.
>    Any buffer overflow will be detected and reported.
>=20
>=20
> *RECOMMENDED FIX*
>=20
> Replace strcpy() with bounds-checking variant:
>=20
> OPTION 1 - Use strncpy (safest):
>     strncpy(ifr.ifr_name, rta_getattr_str(tb[IFLA_IFNAME]), IFNAMSIZ - 1);
>     ifr.ifr_name[IFNAMSIZ - 1] =3D '\0';
>=20
> OPTION 2 - Use strlcpy (simpler):
>     strlcpy(ifr.ifr_name, rta_getattr_str(tb[IFLA_IFNAME]), IFNAMSIZ);
>=20
> OPTION 3 - Use existing validation function:
>     if (get_ifname(ifr.ifr_name, rta_getattr_str(tb[IFLA_IFNAME])) < 0)
>         return;
>=20
> Patch File:
>     --- a/ip/ipaddress.c
>     +++ b/ip/ipaddress.c
>     @@ -170,7 +170,8 @@ static void print_queuelen(FILE *f, struct rtattr
> *tb[IFLA_MAX + 1])
>              struct ifreq ifr =3D {};
>              int s =3D socket(AF_INET, SOCK_STREAM, 0);
>              if (s < 0)
>                  return;
>     -        strcpy(ifr.ifr_name, rta_getattr_str(tb[IFLA_IFNAME]));
>     +        strncpy(ifr.ifr_name, rta_getattr_str(tb[IFLA_IFNAME]),
> IFNAMSIZ - 1);
>     +        ifr.ifr_name[IFNAMSIZ - 1] =3D '\0';
>              if (ioctl(s, SIOCGIFTXQLEN, &ifr) < 0) {
>=20
> TIMELINE & RESPONSIBLE DISCLOSURE
>=20
> I am following responsible disclosure practices:
>=20
> 1. Reporting privately to maintainers FIRST (not public)
> 2.  Not posting to bug trackers or social media
> 3.  Requesting embargo until patch is available
> 4.  Ready to coordinate on patch timing
> 5.  Willing to hold disclosure for 30+ days
>=20
> I request:
> 1. Acknowledgment of receipt within 48 hours
> 2. Timeline for patch development
> 3. Coordination on CVE assignment (via MITRE if needed)
> 4. Notification when patch is ready
> 5. Agreed embargo period before public disclosure
>=20
>=20
> *ATTACHMENTS*
>=20
> Attached files:
> 1. ip_asan_custom (12 MB)
>    - iproute2-6.19.0 compiled with AddressSanitizer
>    - Ready for testing and verification
>=20
> 2. iproute2_vulnerability_report.md
>    - Complete technical analysis
>    - Root cause breakdown
>    - Impact assessment
>=20
> 3. simple_trigger.py
>    - Proof of concept trigger (100-byte IFLA_IFNAME)
>    - Demonstrates ability to send malicious netlink message
>=20
>=20
> *CONTACT INFORMATION*
>=20
> Researcher:     John McAndrew
> Email:          jmcandrew.nc@gmail.com
> Timezone:       EST
>=20
>=20
> *RESOURCES*
>=20
> CWE-120: Buffer Copy without Checking Size of Input
> https://cwe.mitre.org/data/definitions/120.html
>=20
> AddressSanitizer Documentation:
> https://github.com/google/sanitizers/wiki/AddressSanitizer
>=20
> iproute2 Project:
> https://github.com/iproute2/iproute2
>=20
> Linux Kernel Netlink:
> https://man7.org/linux/man-pages/man7/netlink.7.html
>=20
>=20
> I am available to:
> - Provide additional technical details
> - Coordinate public disclosure timing
>=20
> Thank you for your attention to this security issue. I look forward to
> working with you to develop and release a fix.
>=20
> Best regards,
>=20
> John McAndrew
> jmcandrew.nc@gmail.com

Human response: This is crap, go away. Learn to use AI better.

AI response:
Thank you for the report, but after reviewing it we don't believe this cons=
titutes an exploitable vulnerability.

The PoC doesn't validate the kernel's response. RTM_NEWLINK with a 100-byte=
 IFLA_IFNAME is rejected by the kernel at dev_valid_name() =E2=80=94 interf=
ace names are bounded by IFNAMSIZ at creation time and enforced by the netl=
ink policy. The oversized name never reaches userspace.

The code path in question is also not reached on any modern kernel: IFLA_TX=
QLEN is included in RTM_NEWLINK responses, so the SIOCGIFTXQLEN fallback (a=
nd the strcpy) is dead code in practice.

Finally, iproute2 is a userspace utility that reads kernel-validated data. =
Even if this path were reachable, the interface name returned by the kernel=
 is already bounded to IFNAMSIZ, so there is no overflow.

We won't be pursuing a CVE for this. When submitting future reports, please=
 include a working PoC that demonstrates the actual overflow =E2=80=94 an A=
SAN stack trace, for example =E2=80=94 rather than a proof of successful tr=
ansmission to the kernel.

