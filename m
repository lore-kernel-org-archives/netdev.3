Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9FB345EB4
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716004; cv=none; b=M0dCMo8WCNsJxGNv6blBV5jVCq18UkpgaKUh8AbPQWKTCoRo6a93lNsN1GnrKWo4xNTV++peJ/05lX5JEW1zmcjTWpauswmhZlpGeOHcvhfURqrwhjEAv/65ViVx/qfFRxoPkSuAu55/JsWMX/5Z9CBOF9E9sAL7Cn4RjGb5FMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716004; c=relaxed/simple;
	bh=IVdLexSuZcROpf/hvkp6Xr6NU1ovmiPX66oJB2ozh1w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qNCRFfPuTG0FbGuB7ADa3kdz1rQJroZUuzHoQzWuvpFeme0d67HfoZ4Pe3GR0gSkTA3hzkl92d/AbRd3WY8O7NWs6LeTaCcRBxT4sDXl7iD1Y9Pj9LDYsLSVAiWA2AmxdBanznv6m1YvTg7B3lHd22COqO322qDYnPBuuZg0Wrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-49d4cb3ca23so1150765b6e.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 07:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786716002; x=1787320802;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VgtFeurelXguNoym2EWTBBoks03AOBv9fhnKhit1Czo=;
        b=BXxASjxEXy6EjqDmZ+QXURCxzTFEVi1H6HobFDsKPuxX4lCA8u0YOsPWwU+/LwKftT
         7jU9GqWhw/oVtxgHcJmBoi5Bhwie9l49BYfM+MaKyEm2VzEsZa6fSQWGnZKeVkU6AY05
         hxnR3KN1i+VaRGv0CjDqbDkl1qYHQHYVhXp3ZCfQk7zAr2JUdQz68riasOvNKDD94VCl
         10mnlfE++JLMWZs8Hgc3WXrXZe91zsmcf+lNvBDKigSdo+Q9nvCZ3RPXRSZYEj0m648c
         T4S0fkZzD3F2hZYA9zJAlXAO/HnmjmwKIEAU10CZFNOLHHeMaxmXkwiYtqVmZC1/O5fc
         TDFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rry92kpC/SjpVRzzZp8rylmkgOzPgSfMU5t1VXwPCXQfRRNqYgBfyGZyEQTS4PAf8xK6UM6eDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8AGA2nVyoo0iWE3LTGPQpC0qd7xtqCC+o9CjrQOGRh8PUhDYR
	yaHnh4ggVONLAb2Ul121Z3uEGCDlQuMh+HSKVNO0LsADJ65LiyVX52/Kk1QqRkRKnjJbBS7CBG4
	PH8aI8tWU8vJO16dt549d1AgwehnUuwK3LhwWzJ7dx7ISGWwPVJ+H1YDkVkA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:338a:20b0:6a1:98e6:a8f5 with SMTP id
 006d021491bc7-6b0d691c798mr3967518eaf.36.1786716002180; Fri, 14 Aug 2026
 07:00:02 -0700 (PDT)
Date: Fri, 14 Aug 2026 07:00:02 -0700
In-Reply-To: <178671419949.2648204.15668657474779239190@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7f1f62.f7a79266.2f965f.0003.GAE@google.com>
Subject: Re: [syzbot] [tipc?] BUG: soft lockup in do_sock_setsockopt
From: syzbot <syzbot+10a41dc44eef71aa9450@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	immersa.bartosz.chronowski@gmail.com, jmaloy@redhat.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot@kernel.org, syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, tung.quang.nguyen@est.tech
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+10a41dc44eef71aa9450@syzkaller.appspotmail.com
Tested-by: syzbot+10a41dc44eef71aa9450@syzkaller.appspotmail.com

Tested on:

commit:         1590cf03 Linux 7.2-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17a00949580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e9390a601b4f3bd
dashboard link: https://syzkaller.appspot.com/bug?extid=10a41dc44eef71aa9450
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10baba9e580000

Note: testing is done by a robot and is best-effort only.
