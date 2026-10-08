Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAD92FD7D3
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472930; cv=none; b=Ebq6y++WfShlggRHQllSY2HsnXVX5hq7NC0gH1pbnOBApATGmV9PYO4FKgwx01oMA49bAaJdP4K+5T+DU13BmVeug45GCH0gfhW0V90R7gia6IqVhemZzuUpP/QFv0hFKoJNlZqjGpOnLPAzk/8sL+/CorBzjzU4Ab7V6NZ4u4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472930; c=relaxed/simple;
	bh=fIuA9whCacKV925pvaUjv991NN/zR/DeIy12hhZj+e4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ni/hSwmVIdtl+iHfE7q8CMIjCMMrziPiq02tuTOsGqGu7H9DNvE7sVV2HGH59VBVJ4lPSt3TDD/sm/iC8kok4ySyrm2AtN3EacON307f93xa3HZWr/pWruuRgcWGFYu+ndzGowYj9Eq9iYRNX7YbthcwDFzDi0QtYdT389jO9Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4c55ba309c2so8476934b6e.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 08:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791472922; x=1792077722;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kKU/hlDwcyb6DqIvdpCvOhi9jIEa0I9l49IKIqJc1+k=;
        b=Hs3kQTEqs0M68WiIw4mc2k90BavmI37h0GzTJEQmHyXRn6FMcuCrUX0JWZGUffuoB6
         mOhfUW6ToAaKblNpNqHWlvyElXMLwC5wPzEhczwrCdr09ffDutr1XnIr8iQRTkQ82h0v
         c7caPKgu2HWoA2BQrU8lH6pCbFln281IZjpGJeAFutNL9itPPjpMEV3qSclYO6PCptng
         pDEjwql1XKV7pFw6H5DT59la6El6xSwqecDkzDwkWKazomDUmvmZJ5ZdryQ+1yXHBmHH
         XyiMiIX4s8s41gFXVLDm9idhs6RPc3FZ4MpN04ttsyU3yV6w7BmtQD8BIo0yEjJTat7M
         Ym6w==
X-Forwarded-Encrypted: i=1; AKwUvBzxXDJDRiQbsy5EOCqPSc3m7LV+dbx+YRVro58JGl/GhSp0h1Giz0wRtXTCtb9xlEhym7iBChM=@vger.kernel.org
X-Gm-Message-State: AFuF++llfIdykmrMGm7BWrnQ6DkkrmYPVaBOeLyRjxoaMUNb3JE3AtvS
	YWCjbcbHh7Rl9zgKJuApWxBFsWNEkSQEd1DR+y8+2OaZt+MRCadOUysuyS5xMvfhvI90Vh3i3N4
	lRC3GPCLol+aFr2NuxTuzxWphWJ+FecMIAhhNlHVrfk0KjX7HDKQG0sDRv0s=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c3e9:b0:4f5:4f8:889 with SMTP id
 5614622812f47-4fc46f9343amr5239271b6e.62.1791472922602; Thu, 08 Oct 2026
 08:22:02 -0700 (PDT)
Date: Thu, 08 Oct 2026 08:22:02 -0700
In-Reply-To: <asddK6J6bt2YFJPb@nr200>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac7b51a.bbc4c7f9.15faa7.0004.GAE@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in device_move
From: syzbot <syzbot+1f4e278e8e1a9b01f95f@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, kriish.sharma2006@gmail.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, rafael@kernel.org, 
	sst@poczta.fm, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1f4e278e8e1a9b01f95f@syzkaller.appspotmail.com
Tested-by: syzbot+1f4e278e8e1a9b01f95f@syzkaller.appspotmail.com

Tested on:

commit:         5fce1616 Linux 7.2.9
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-7.2.y
console output: https://syzkaller.appspot.com/x/log.txt?x=166c7c3e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fe117ee605b5143
dashboard link: https://syzkaller.appspot.com/bug?extid=1f4e278e8e1a9b01f95f
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
