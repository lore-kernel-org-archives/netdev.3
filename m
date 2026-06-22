Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6340200110
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150471; cv=none; b=fIVN/OzGzIiWvNhX9hPfatuy2CevJ6RWVEqBD4Ckxjy7XjJfG38928CVqH/3ubrHM1RoJTM8J2kQgUkNuc2BSNfRmqweKtAI/ahXeK7lhVM9aAWHs/q+qcpAuZLbxIrQ1Ak0vTBzWqssAe6msIGj50wxuTxVZ9LBMuJpxMTwvxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150471; c=relaxed/simple;
	bh=LaZ5EhZYa7+Gj+9Pq6GcRqcO9EiTlBpyFJvT0QECMYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RL7taeE/qaNRPgMwAe/7CWEK+Rkh9Ty4UwdndRDst34EUJV8vygQxgJ6XvkwUOIuVmhv61MhzBXBKwDOwE5FyOzraAO8WdwQd9kAZ4LohUSWlnEwUKgh5mzokZCEyPkqns9pfVwC+QgqiRKeUfaIcAjxiumgPu9Rien/QS7AOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNFZ/lgE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNFZ/lgE"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4921e4dd62dso1404855e9.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 10:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782150468; x=1782755268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Unjyydy0GXKCju/zqit9QOD+pb6c0Sd1CZtTwQE6PPQ=;
        b=mNFZ/lgE102zcwnBhPY88yEqRON1Y7M391ZRRAXdqLjqpOrIP6wMUCJy93M2NghUTZ
         e/G1s/HpOzumIO+nDV0MbndZwQA8PDF7ViGdMhNsS59ecQ2QdSDmZFk6uJcLMBoXGSQ4
         u6iF3vfps4K8YJTjF76s55IhmKKBtxd3X6pwEqCRIwVnEuG3H/A3E6RJhpvcVhzgQCsw
         PYt+saz+NvLegKbnUxE3KQfdAbQmJKuv4rMjx1zV0On1LGqMgf03pC6E6reeZhta8ZDv
         v06myV1Jyo4qBQlBFjAiHoZ2P9YR3lcujbWq6GVUrNNfnt8LjzCH8Nui2OIc0FuhWSil
         YtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782150468; x=1782755268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Unjyydy0GXKCju/zqit9QOD+pb6c0Sd1CZtTwQE6PPQ=;
        b=brkufp2OXe5BfahCTK/PIHvqraysU4pttNnG/XaHUsiVlV40kET9RfUpYAhLsm9aSz
         3NE6e8UaQOqkAr8A9zl68/ZfdzYi1MncAFf0+MMJjyKC7px6D1i4kg1+QFhbnGkGhosN
         KyYS4RHWe54uNm8TOTs1xKA36U0JC5OI8x+adMI9BcCC39HOeXVr63fcT8slv2vlt9AX
         7WNSPEFtnUrJ9ngEs8M4hEa+YdbO7TtSWGwi6mrkMEJlw7mcTwjVjYn8/tZ0OIh+wE38
         aiSBUwkS2dw4n9OqBdWVgjuSfiHklh6FiD3dNQl4Jx8Gdeiqj5BDs6PV4+iZ+E4TiiP4
         TJLw==
X-Gm-Message-State: AOJu0Yz6hTsGFSgCc7NE5RQdmy6X9jwQ1z28dzOart3J3CPKD+2IGM+u
	SoqZkD3BJHSDJZPdwXt1EKDKPuZh++XM/AmQGWyr02VCbfMoQ0nvSeWAgOhqdoML
X-Gm-Gg: AfdE7ckkLxuMQfJDc4zQ0ddBz9zWHU2DLHIwO2+xE0j65Fsis6aEVqETeCpqx4vp3Dk
	fJHnd4QKXKxyoqMRNsDGRnGCSIi+JJTKFws+qfs6/sxGMb+6Ej4sy+qYDRrvaHWwB2mMl3iY/rd
	9CUmyBFg1ipboGZ184qD8S1XUipSlRrcbEDUNe9fICD3UN3++KO2NPPWXgnrLyeLbIoLHIEuD8N
	22vtGPiODL2jPnuUTZJ65026PkK3KYQlekRl0JRU0SwKCHleC34Y2ETJAvGlHeMe0aoL/gOCoPA
	GP4/pNjY7QFURQds8LypkxJnhMnJkADgbvKC4zNuRrbkTrw9u1kgA3B29CNWlTqdaASRsZ7d9QT
	xFxlM4YGgzLJ9OvtNCb/apGagfSN6Ay/G+58s6SP6JGW3/XTPIHTc80Q7l7t/+wRd8pAoi27/be
	36TbENyo0f2CB4uQUVxexjKRC7Y50d/zVHmaABYNH250+D0v47AuIxA80=
X-Received: by 2002:a05:600c:5010:b0:492:1e36:9a90 with SMTP id 5b1f17b1804b1-4925a0da5cdmr7290355e9.18.1782150468052;
        Mon, 22 Jun 2026 10:47:48 -0700 (PDT)
Received: from ?IPV6:2001:bb6:1b96:9200:cf2e:dbb6:5a08:1ea4? ([2001:bb6:1b96:9200:cf2e:dbb6:5a08:1ea4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fe7ba08sm311034415e9.11.2026.06.22.10.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 10:47:47 -0700 (PDT)
Message-ID: <3d6f256c-3bd0-441a-bece-8692985c5ddc@gmail.com>
Date: Mon, 22 Jun 2026 18:47:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] "ip help" wrong output, exit code.
To: David Laight <david.laight.linux@gmail.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <62f09fe8-899c-4d22-b7a1-67e2745613df@gmail.com>
 <20260621082105.1196ef72@phoenix.local>
 <069b13e1-f689-410b-bd40-b5e5831b67e7@gmail.com>
 <20260622075700.27806286@phoenix.local> <20260622174454.576b3580@pumpkin>
Content-Language: en-US
From: Dmitri Seletski <drjoms@gmail.com>
In-Reply-To: <20260622174454.576b3580@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello David,


Based on change introduced:

Two samples of "ip help" with demonstration of exit code and standard 
output are below.

This is in line with what expect.


dimkosPC~/compiled/iproute2-next #if ./ip/ip help a >>/dev/null  ; then 
echo help triggered  ; else echo error code triggered  ;fi  #this 
redirects standard output  to /dev/null, so text missing is not error,
but standard text
help triggered

dimkosPC~/compiled/iproute2-next #if ./ip/ip help   ; then echo help 
triggered  ; else echo error code triggered  ;fi
Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }
       ip [ -force ] -batch filename
where  OBJECT := { address | addrlabel | fou | help | ila | ioam | l2tp 
| link |
                   macsec | maddress | monitor | mptcp | mroute | mrule |
                   neighbor | neighbour | netconf | netns | nexthop | 
ntable |
                   ntbl | route | rule | sr | stats | tap | tcpmetrics |
                   token | tunnel | tuntap | vrf | xfrm }
       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] | -r[esolve] |
                    -h[uman-readable] | -iec | -j[son] | -p[retty] |
                    -f[amily] { inet | inet6 | mpls | bridge | link } |
                    -4 | -6 | -M | -B | -0 |
                    -l[oops] { maximum-addr-flush-attempts } | -echo | 
-br[ief] |
                    -o[neline] | -t[imestamp] | -ts[hort] | -b[atch] 
[filename] |
                    -rc[vbuf] [size] | -n[etns] name | -N[umeric] | -a[ll] |
                    -c[olor]}
help triggered

Two samples of command that is broken on purpose.

dimkosPC~/compiled/iproute2-next #if ./ip/ip idontexist   ; then echo 
help triggered  ; else echo error code triggered  ;fi
Object "idontexist" is unknown, try "ip help".
error code triggered

dimkosPC~/compiled/iproute2-next #if ./ip/ip idontexist  >>/dev/null  ; 
then echo help triggered  ; else echo error code triggered  ;fi  #this 
redirects standard output  to /dev/null, so text missing is not error, 
but standard text
Object "idontexist" is unknown, try "ip help".
error code triggered

This works as expected as per my understanding.


Not everything is fixed, but chunk of things fixed is better than non of it.

for example:

if ip  add help    ; then echo help triggered  ; else echo error code 
triggered  ;fi  #this redirects standard output  to /dev/null, so text 
missing is not error, but standard text
Usage: ip address {add|change|replace} IFADDR dev IFNAME [ LIFETIME ]
                                                      [ CONFFLAG-LIST ]
       ip address del IFADDR dev IFNAME [mngtmpaddr]
       ip address {save|flush} [ dev IFNAME ] [ scope SCOPE-ID ] [ to 
PREFIX ]
                            [ FLAG-LIST ] [ label LABEL ] [ { up | down } ]
       ip address [ show [ dev IFNAME ] [ scope SCOPE-ID ] [ master DEVICE ]
                         [ nomaster ]
                         [ type TYPE ] [ to PREFIX ] [ FLAG-LIST ]
                         [ label LABEL ] [ { up | down } ] [ vrf NAME ]
                         [ proto ADDRPROTO ] ]
       ip address {showdump|restore}
IFADDR := PREFIX | ADDR peer PREFIX
          [ broadcast ADDR ] [ anycast ADDR ]
          [ label IFNAME ] [ scope SCOPE-ID ] [ metric METRIC ]
          [ proto ADDRPROTO ]
SCOPE-ID := [ host | link | global | NUMBER ]
FLAG-LIST := [ FLAG-LIST ] FLAG
FLAG  := [ permanent | dynamic | secondary | primary |
           [-]tentative | [-]deprecated | [-]dadfailed | temporary |
           CONFFLAG-LIST ]
CONFFLAG-LIST := [ CONFFLAG-LIST ] CONFFLAG
CONFFLAG  := [ home | nodad | mngtmpaddr | noprefixroute | autojoin ]
LIFETIME := [ valid_lft LFT ] [ preferred_lft LFT ]
LFT := forever | SECONDS
ADDRPROTO := [ NAME | NUMBER ]
TYPE := { amt | bareudp | bond | bond_slave | bridge | bridge_slave |
          dsa | dummy | erspan | geneve | gre | gretap | gtp | hsr |
          ifb | ip6erspan | ip6gre | ip6gretap | ip6tnl |
          ipip | ipoib | ipvlan | ipvtap |
          macsec | macvlan | macvtap | netdevsim |
          netkit | nlmon | pfcp | rmnet | sit | team | team_slave |
          vcan | veth | vlan | vrf | vti | vxcan | vxlan | wwan |
          xfrm | virt_wifi }
error code triggered

This is still problematic.


But so far code leaves "ip help" command/argument in better shape than 
it found it in.


I may try improve things more, but lets submit what we already have 
"better", please.

Kind Regards

Dmitri Seletski


On 6/22/26 17:44, David Laight wrote:
> On Mon, 22 Jun 2026 07:57:00 -0700
> Stephen Hemminger <stephen@networkplumber.org> wrote:
>
>> On Sun, 21 Jun 2026 22:48:59 +0100
>> Dmitri Seletski <drjoms@gmail.com> wrote:
>>
>>>  From 0805e07105cd15c5b94271a4706e50e3c65dbde5 Mon Sep 17 00:00:00 2001
>>> From: Dmitri Seletski <drjoms@gmail.com>
>>> Date: Sun, 21 Jun 2026 22:12:43 +0100
>>> Subject: [PATCH iproute2-next]  "ip help" wrong output, exit code.
>>>
>>> Changed output of "ip help" from standard error to standard output. And
>>> Exit is now 0 instead of -1. "ip help|grep bridge" - now gives bridge
>>> syntax instead of flooding user with everything from "ip help".
>>> ---
>>> ip/ip.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/ip/ip.c b/ip/ip.c
>>> index e4b71bde..4627b61c 100644
>>> --- a/ip/ip.c
>>> +++ b/ip/ip.c
>>> @@ -56,7 +56,7 @@ static void usage(void) __attribute__((noreturn));
>>>
>>> static void usage(void)
>>> {
>>> -fprintf(stderr,
>>> +fprintf(stdout,
>>> "Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }\n"
>>> "       ip [ -force ] -batch filename\n"
>>> "where  OBJECT := { address | addrlabel | fou | help | ila | ioam | l2tp
>>> | link |\n"
>>> @@ -72,7 +72,7 @@ static void usage(void)
>>> "                    -o[neline] | -t[imestamp] | -ts[hort] | -b[atch]
>>> [filename] |\n"
>>> "                    -rc[vbuf] [size] | -n[etns] name | -N[umeric] |
>>> -a[ll] |\n"
>>> "                    -c[olor]}\n");
>>> -exit(-1);
>>> +exit(0);
>>> }
>> Your mailer damages white space.
>>
> The output also needs to depend on whether these is a 'usage' error or
> if 'help' is requested.
> Code code is correct for the former - except it should do exit(1).
>
> 	David
>
>
