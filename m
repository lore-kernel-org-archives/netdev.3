Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CF2223DE9
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780850379; cv=pass; b=kGWVrFka9wTIdpT1Y8cTEA/SgE02C6W1NGLAFU98lazE5wg4Zr9M9iy45g4JPp4F5hbGGhrjkEkmqSnDFHOOwWf7ugXpievj4rdhmg0sNZYwIT4ucekXqGD0inWdbW9XtGndIMe74f8nDIC0MIp0a7ikpcs1Dn4rsl/30RrAQ6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780850379; c=relaxed/simple;
	bh=aZfvW5qlm08Z6cAsmRjpaKkg8fk6no1tZyfdpgmnUyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCpKeXcY1CfyF+qyyedo5CjmaIzCPOsQXzLxJEWU7CgAMHI6Ig/mrUNLatp5e9VKJCZb7h0IZ74fssVcxb+QeHLiiK+8ubuj4S0xtHXZPrS2VQivRSNjdklBPqFKepJMdOTWHUPevNseJPAkILRnwAdU4P4xmlNGGLhTE1rEnfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pv2B6EFb; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv2B6EFb"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4854166e1efso3510483b6e.3
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 09:39:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780850377; cv=none;
        d=google.com; s=arc-20240605;
        b=JYutJQzdnO2dQTARFPFR5IFSNcjOGrcQ/hT//1Pr6pRLZu0vO7Ol+BOUSyzf7JCAW8
         FMcVjdP/FbBmK583ENfy33dn6GuUpzTP2n+aLjpv8tVVpoiD5K3u4Y1k233jHAF7zPyk
         jgNC4EgqGlOvfUj5EZ+T5z1bSkNVztjFUGa3MTGoWeS1E93j0htWtCVyCzY9QCgH1ryj
         4Y/C8D0Yzgz0mCkJ4qQg310bS6Zzz3q/56BoiAQqyL1BE0zNAa3c/zu2d+oSpJxm0YBo
         fxtrUiPhYXD3f+ozpwl+zLK1OwK+YICXf2fKGYqIagsBcmV7a7bTSx/j7STVe6mh82L2
         9kqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DicLQFuJxU23McocBCUnupcyFssPDQMMi8zUVhLjO8o=;
        fh=+QqGPzJbav1WFVYltr6nl+952Q5uZkK6egP168UuvGU=;
        b=XMIXJSWDcvYTppbYFUiGTyW8QYUEswZpsuoW5iIQ+W9pTtvCQTLc6y0KIUdBHFjYRw
         R0qAVob+FytNZKtHxg6xuqmIS+gtW0Ye+2vgQ4d/Tg9qkEeRwEC97/T3Xwj4wtWpMVfF
         Mje80JjsnIGF5VgeG0KWjUzlZN79wZoa4SiTbGCA8RgUWhILusQOW0JQYmH4OyFm3wcT
         oA9XAPs5I7ZUI2QkXxAfmwOzg/2lfFS/oYhEc2L1kqoHcc5rSACbR9FetdEXoQNCDLo1
         cMx9ddsVC23qOXdmczkw9w5oRInq1BfWdBGENZ16FdCdOqDdMd+xXJ6kwNL5pOjwYB0r
         EdJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780850377; x=1781455177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DicLQFuJxU23McocBCUnupcyFssPDQMMi8zUVhLjO8o=;
        b=Pv2B6EFb/ixPQWhVWanqWtQq9iQ775LzTp+qgEz8n7dsWna68/0pvioMckCC70Iga+
         y6FYK6TP0xZZRzRAwDUh+E9jDZpWlqRALCY960H7uw5PSHG66/gZZew+Q1TgwyDLBi3c
         IGp4avL9qbDYlZLxMvbrMyWlXDMs9LtzwQYxBgw8RJOVqw862ao+23gf3DCQsBBaWduD
         bmkV5LOSk68xXGbRuHZPoEXw2Pxoy5JibJpZQrZNpJshbQIMHs+eiEqXIq+7n2BaCzSn
         sIwvbiGAURvpfpsJuJLJgZWv1hbuqRJa5U/VeqSyaTLCpsf56RCa2HzTaXfnlI9hOz53
         3MEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780850377; x=1781455177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DicLQFuJxU23McocBCUnupcyFssPDQMMi8zUVhLjO8o=;
        b=jXBCbbuTGAtBvb5LM8c5zLvrTM6ARfuoWPprAVwwH3F3vkoYTth1j9877qEvNlO1yO
         ecg5c7koUdv9bCsQoWNN8d5LiArDuIdo6uqI2OrxtzAnR6xusMYUkplYZKaHTH8tN1F2
         pSqLXRKPCO7bXXK6a4KqP3nj0LsyJlf2QfFRYHD3XUNvLlz72mVdmz8w6D6owhotFn55
         lPb+ra+rkaPLZ98nUREv/2NJRRrTJnyaDlQlk1f7p77OVIUObhqnNVTZt1Jz4Vw0CqtE
         sq85u7wf0LSbAYDn/JnaQ6XJ/Vd9MXenmE0RP/twZCNwQQzPe03WvGFsvzLyXANrrmIo
         EfBQ==
X-Gm-Message-State: AOJu0YwOqQYv70sCTx8W2w59vE/wXbWnVvZC/lXzIGNncoiC4M+PMmim
	7/X3U5esrQHbliP/o8PzkCEAWpxa6gMjHe+6dAsgl5+QjMlU0ByNKpTWGE6NOXcEFI6YJ73jAr8
	gR1FdeFcl/l4bSfLlyz4mWMnVJZjtpvY=
X-Gm-Gg: Acq92OEmsrYF7vXw1asIBEscPyJ+ljMepOtUDWzwV3yV6074a9BbTkyj+0JpsYxe90D
	1v/RtKaOdmN3HW+CYEptavSeI7D85sF7lBuGcEGny/hufZN/TtenJi3ewm33K6HBKIoSyno9XfL
	4dXnva8UOUuUYeqaY8q3T1soGjkkwr5NjnKspwv+9nTPrI+7AfF6mBlzVvKs9VMcp89NVVPUnla
	v8lC0nv1yVFpZzwTAIPcQxy1bQodHFKisFXS3UCIpn0D64QLscCW3sBRJtuPDzyi+o5X5jwmuRC
	zc1uDQStYHDe/l8lK2o=
X-Received: by 2002:a05:6808:2388:b0:469:fc59:b128 with SMTP id
 5614622812f47-4868def1f81mr6761464b6e.25.1780850377000; Sun, 07 Jun 2026
 09:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN2cbVe79oj0O9==m4+4x3v+O+qzRagA=2=wkrp9i9=CqYvyZA@mail.gmail.com>
 <8978c158-b005-4b53-99d7-b475d9c4c665@mojatatu.com> <CAN2cbVenex+3wB0o+rvxcFrQOTjAL3W_WQ1sh7QZ_AKewgRVVQ@mail.gmail.com>
 <CA+NMeC-cpoV8X44wTXm=a+Xkpx0Ka0uydG1fUNqM_0vFEh2GTA@mail.gmail.com>
In-Reply-To: <CA+NMeC-cpoV8X44wTXm=a+Xkpx0Ka0uydG1fUNqM_0vFEh2GTA@mail.gmail.com>
From: Anirudh Gupta <anirudhrudr@gmail.com>
Date: Sun, 7 Jun 2026 22:09:26 +0530
X-Gm-Features: AVVi8CezqMiC2SKz1hdpx6MbNvtZqEZ4vku4MaHOnc8cDYV_8yuISEOQnQttgr4
Message-ID: <CAN2cbVfu3OQ31eejnPASukW_BMVqucUJcXev7KzbCEgdv5QH6w@mail.gmail.com>
Subject: Re: [BUG] net/sched: HFSC + fq_codel stall on 6.6.116
 (qdisc_tree_reduce_backlog / qlen_notify)
To: Victor Nogueira <victor@mojatatu.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"jhs@mojatatu.com" <jhs@mojatatu.com>, Anirudh Gupta <Anirudh.gupta@sophos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Victor,

The new patch seems to be working fine. I could not reproduce the
issue with this new patch.

------
Just for reference, I'm using following setup for reproducing -

Setup topology -
[Client VM] (eth1 - 192.168.168.1) ---------------------- (enX2 -
192.168.168.2) [ DUT VM ] (enX0) ---------------------- (server)

Environment of Client VM -
-----------
kabir@KABIR-CL-1:~$ hostnamectl
   Static hostname: KABIR-CL-1
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 9cf567e712893204a35b60a064423b22
           Boot ID: 35ea99b0bfb74da792ef87e62ab30d90
    Virtualization: xen
  Operating System: Ubuntu 16.04.7 LTS
            Kernel: Linux 4.4.0-210-generic
      Architecture: x86-64
kabir@KABIR-CL-1:~$ ip route get 10.179.64.152
10.179.64.152 via 192.168.168.2 dev eth1  src 192.168.168.1
    cache
kabir@KABIR-CL-1:~$
kabir@KABIR-CL-1:~$ #using following simple loop to download files via DUT =
VM
kabir@KABIR-CL-1:~$ while true; do wget
http://10.179.64.152/ta-testfiles/http_proxy/random_20M -O /dev/null;
done
-----------

Environment of Device Under Test VM -
-----------
kabir@KABIR-CL-2:~$ hostnamectl
 Static hostname: KABIR-CL-2
       Icon name: computer-vm
         Chassis: vm =F0=9F=96=B4
      Machine ID: 8522b84c24c449e09a21d02cdcf0fcb5
         Boot ID: 5f5199fcc953492281f481de1907f32f
  Virtualization: xen
Operating System: Ubuntu 23.10
          Kernel: Linux 7.1.0-rc6+
    Architecture: x86-64
 Hardware Vendor: Xen
  Hardware Model: HVM domU
Firmware Version: 4.13
   Firmware Date: Wed 2019-12-04
kabir@KABIR-CL-2:~$
kabir@KABIR-CL-2:~$ ifconfig enX2
enX2: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.168.2  netmask 255.255.255.0  broadcast 192.168.168.25=
5
        ether ba:c1:db:23:fc:d9  txqueuelen 1000  (Ethernet)
        RX packets 44  bytes 1400 (1.4 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 194  bytes 29478 (29.4 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
kabir@KABIR-CL-2:~$
kabir@KABIR-CL-2:~$ #### compiled provided patch on top of linux
stable git master branch kernel
kabir@KABIR-CL-2:~$ uname -a
Linux KABIR-CL-2 7.1.0-rc6+ #10 SMP PREEMPT_DYNAMIC Sun Jun  7
09:20:39 UTC 2026 x86_64 x86_64 x86_64 GNU/Linux
kabir@KABIR-CL-2:~$
-----------

Then to apply tc chains, using already shared apply_tc_tree.sh script,
to redirect all ingress traffic of enX2 to ifb0 -
=3D=3D script execution logs =3D=3D
kabir@KABIR-CL-2:~$ sh -x apply_tc_tree.sh
+ sudo modprobe ifb act_mirred sch_htb sch_hfsc sch_fq_codel cls_u32 sch_in=
gress
[sudo] password for kabir:
+ DEV=3DenX2
+ sudo tc qdisc add dev enX2 handle ffff: ingress
+ sudo tc filter add dev enX2 parent ffff: protocol all u32 match u32
0 0 action mirred egress redirect dev ifb0
+ IFB=3Difb0
+ sudo tc qdisc del dev ifb0 root
+ FQ=3Dlimit 10240 flows 1024 quantum 1514 target 5ms interval 100ms
memory_limit 32Mb ecn drop_batch 64
+ sudo tc qdisc add dev ifb0 root handle fffe: htb default 1 r2q 10
+ sudo tc class add dev ifb0 parent fffe: classid fffe:1 htb rate
800mbit ceil 800mbit burst 1600b cburst 1600b
Warning: sch_htb: quantum of class FFFE0001 is big. Consider r2q change.
+ sudo tc qdisc replace dev ifb0 parent fffe:1 handle fffd: prio bands
8 priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
+ sudo tc qdisc add dev ifb0 parent fffd:1 handle 1: hfsc default fffc
+ sudo tc class add dev ifb0 parent 1: classid 1:1 hfsc sc rate
800mbit ul rate 800mbit
+ sudo tc class add dev ifb0 parent 1:1 classid 1:9 hfsc rt m1 0bit d
0us m2 4096kbit ls m1 0bit d 0us m2 1kbit ul m1 0bit d 0us m2 8192kbit
+ sudo tc class add dev ifb0 parent 1:1 classid 1:a hfsc rt m1 0bit d
0us m2 320kbit ls m1 0bit d 0us m2 1kbit ul m1 0bit d 0us m2 480kbit
+ sudo tc class add dev ifb0 parent 1:1 classid 1:fffc hfsc rt m1 0bit
d 0us m2 8kbit ls m1 0bit d 0us m2 1kbit ul m1 0bit d 0us m2 800mbit
+ sudo tc qdisc add dev ifb0 parent 1:9 handle 9: fq_codel limit 10240
flows 1024 quantum 1514 target 5ms interval 100ms memory_limit 32Mb
ecn drop_batch 64
+ sudo tc qdisc add dev ifb0 parent 1:a handle a: fq_codel limit 10240
flows 1024 quantum 1514 target 5ms interval 100ms memory_limit 32Mb
ecn drop_batch 64
+ sudo tc qdisc add dev ifb0 parent 1:fffc handle fffc: fq_codel limit
10240 flows 1024 quantum 1514 target 5ms interval 100ms memory_limit
32Mb ecn drop_batch 64
+ sudo tc filter add dev ifb0 parent 1: protocol ip prio 1 u32 match
u32 0 0 flowid 1:a
kabir@KABIR-CL-2:~$
kabir@KABIR-CL-2:~$ sudo ifconfig ifb0 up
kabir@KABIR-CL-2:~$
=3D=3D logs end =3D=3D
Post these steps, will continuously send traffic from client, and
monitor tc stats in DUT, in case sent bytes are getting stuck and
backlog keeps on increasing.
--------

Thanks & Regards,
Anirudh

On Fri, 5 Jun 2026 at 03:02, Victor Nogueira <victor@mojatatu.com> wrote:
>
> On Thu, Jun 4, 2026 at 11:23=E2=80=AFAM Anirudh Gupta <anirudhrudr@gmail.=
com> wrote:
> >
> > The provided patch did not fix the bug.
> >
> > Observing the same issue, where sent bytes get stuck and backlog
> > continues to increase, while traffic gets stuck.
>
> I can't reproduce this locally with the previous patch, but investigating=
 the
> code I think I understand what might be happening. Can you try the new
> attached patch instead? If it still doesn't work, can you provide me with
> more details on how you are reproducing (environment, traffic
> generator and etc)?
>
> cheers,
> Victor



--=20
Regards

Anirudh Gupta
