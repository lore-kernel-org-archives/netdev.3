Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC053BE621
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721826; cv=none; b=tAM4stMIdw5MDKdlpsKzwEf8/O6vt6Q0RRkx3wFH7XTSR1c1U7dUik2vCoqePMFOQIQYAshniQoVcHaRXBFgmf0Es5Zh6KIrFNHzl/tTzgfpNDaCUtD4iSUP2eiXDB5OtAj7MBdx/19xtuwvb6Oh7fX7f02wTgJUFvYo4N7omTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721826; c=relaxed/simple;
	bh=jAOZbkn08GluNkAut/VWYrhV3dmIAcmzWg7nJGMOaZA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TZfaXbV3TJ96JwjM3psFhV8364c/EjiDcWLYEVLmUFVMF+LO5VCnCjDYyObxa75Yr18PWFdAQ2QjZAe076zVH9cQEf+Vb0So3FGRq3A2U1gJNwVAedp4Slb/zBc9P377IpnnplATXidjIosdieQgrGATHet09XrrN94qySb2ueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-44aeefa1a30so1953218fac.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786721824; x=1787326624;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3SXVIevth3kdKwpj2rPXKrxZoHAl07ZBGGqpeNhRSG8=;
        b=DIPlin/79YpFEz78Z+ClKjz0Q1J8QFS4G+KzkQvaOuO1xNHLIV8L6CzN8ZPopMZjAW
         lfD7lO+1Z7lK0q0OTKYUIb9HFmUrFWvk7NnTyJzdkETJgQHNda/l4b5CEYIJS4HAdKvg
         L3iPm0eYxFKZ3F5fqNEgkRT4AQLEv7zlU5CJEbf3cwAJMHfXsfBt2r9fMw/FjUKY0gv7
         6OkTwJZTLy9FIMej41ZMnoXr8j2K2tG/wIPW1widhVMo5p/aqKi50/rkER01TLzBlNcQ
         tR4g5qqiO8uo9QY7NH5uZ/UW1Zg1jf1j733LiDDVB79vjpWlisGdNTvdr2Elm0s15rQW
         sKpA==
X-Forwarded-Encrypted: i=1; AHgh+Rot/D9bAfp2nxLY2MIwo+qETJTbxPwEOCy+Q5zr2dR+LgVzVn0afNuUNDlXllgSZZkjk/oImb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvx9/Vs2om89fFRLJBDNDTGIjCE6JKfYexomoaY5v62P+Pk8G7
	qErtVkB/+Wqzdj9oeW3ipV1QdvJ06BWerySuIpLoe2ihUR3/O9RV5fzJM5qmHxix9FhbJsrv2g0
	AhkUeDv+kNkEeB5bT7CEY0ZbQSvu5ohhGwiql29QC883WS1/9vF3llEp4zoA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:83cc:10b0:6ac:9756:c70c with SMTP id
 006d021491bc7-6b0d6257a2cmr4388341eaf.20.1786721823020; Fri, 14 Aug 2026
 08:37:03 -0700 (PDT)
Date: Fri, 14 Aug 2026 08:37:03 -0700
In-Reply-To: <CANn89iLye45x8mhXm5-rcttmCqjDKEEXR70o9jJeFy0kOp0zbQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7f361f.9ebadd4d.20b15e.0006.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in rtmsg_ifinfo_build_skb
From: syzbot <syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, sd@queasysnail.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
error: corrupt patch at line 7



Tested on:

commit:         2f1baf1f Merge tag 'trace-v7.2-rc7' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=f2f6312ad1b5a0bfe316
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14828279580000

