Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689606;
	b=PqEzaFrucXxDz/zKC9k5D1K/4BB8myZTFyLhXgx9Sc684D/ZqwISYTk4MnSHn//Fy6yu
	 0A5nPY7FOaxJvRTLVi+b9/7613GrAM1VRJ3TVaCzuKtZNXwLwFeCyp8Xfa1ALgyKEQo+K
	 XlIBcIzf9ZtGfSJQbr95RWZPdx8rZTDX0CB+sQXwYRdbOeleoWo7FYHlLZZTKoJW/o0l2
	 FBO23134G8XpZqybAnJnyIVLXQVUBqqQ80uPyhNwfDxf1HFkVHH2L5qf40xOHGP00N8hH
	 wYJhB/3Zbq4p6dS40A6woR7r8+Thzl7q4F+3mXzbsSkE0BaZyhnMvkSCbH+zDavW9eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689606;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=4UT4wBei7lo5P9ke+g//ajLXiPvxYYsQ7T5yHwgF27o=;
	b=gd32VyJclRVUruz0uhIizOLioKMwzijhLbStiVw3wOKlMfqy/0c5x7TPjlowuUaq/jmu
	 FvEkqchj72gT9qbxKoFQpmMKtF2vu6Ch3oV1aVIuzvGEaLPQAHpU866gIKQcSrGRv+7hb
	 XPC9I0q9U82y2M7/6PobVqGE5QJbf2sjvEUby6ZXwbHT/AIv5M1/nlPDvCQdo2l2lsZGS
	 4Uq+bpyPsR0uPeolkvtnGUcyaun/8J3p8NG3h5Ft6uBaUlBSsmBM4pPofsMKwDJvoDXx2
	 uWeCXbPZXOqF7vmzHMIHQ2cZLS2AJfTK66yHpJeO7Y+rvx9x1Tz1w/wGGJhvRbahEaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5EC606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D5EC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-5384e381fbbso102165b6e.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792689605; x=1793294405;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4UT4wBei7lo5P9ke+g//ajLXiPvxYYsQ7T5yHwgF27o=;
        b=u/aaqyNJvw+vx2aeS+AsEF/75MV7NWTLsxDt6ETqaHWDHPIrad0vroZkBlyj75yDJ5
         cnWCGm+JubJuW/Cxovrw1Hv7WEMQJKG7jYuPOInvOWpSnEpoCUyxFtYqL52k+qiNgzcC
         Zzvnj1+E/TxwZUcX7tE/M/O92hXEDgcFXzkIA0mJkcaKApfaEEfpzqTWwnkXrW2XL5zj
         wKe9bwa70O0w+SHZiX3eXznzUGtSNObNFAo1P5RD2pk4r9ALVk2LN0Irsv/QD0P6m9Kb
         XnSYgX27YlluBoh/9tGrREMNkgjxqciVYJwF0h6cQZQSofumwI7xVZUuhqRXgWVXI4yU
         iwww==
X-Forwarded-Encrypted: i=1; AKwUvBzX/o5s39WKzFUXYN+9d6v7ibrAZltqJe2pigcx1ybao2SONCdw56uj5asvNQ8+g7NkkJnUgDE=@vger.kernel.org
X-Gm-Message-State: AFq9FYINT5wq2CWkzhNOYc4BTAkDd24CyuNrqFPoYXmpJpPIuH9k6guM
	eMvjal+EE8WfeTRRLMGblyBDOIGhGp8l9JQ/tYBbOVqUtdqwB5CYGPWwhHEnG/Eijd/vjlgz4ks
	eu3oc5w1RL98QntnvuVUZIV7/AKP/r8Xh5RdoIT8kJZ4CfUQYvwmkTCFVb8Q=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4fe1:b0:4f2:f229:1895 with SMTP id
 5614622812f47-5535c2846ddmr5380130b6e.43.1792689605345; Thu, 22 Oct 2026
 10:20:05 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:20:05 -0700
In-Reply-To: <CAO+rqLgLRszT2U_x49hYVULuJ6Lm-80EdokzQUyNO_mECKEvKA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ada45c5.d1c214cc.659fa.00dd.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING in nf_flow_table_extend_ct_timeout
From: syzbot <syzbot+521f7e7e2b974abde99a@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	edumazet@kernel.org, fw@strlen.de, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mike.michalo@gmail.com, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	phil@nwl.cc, stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/main: failed to run ["git" "-c" "core.hooksPath=/dev/null" "fetch" "--force" "675adff2843877c2da27b36b2517f827bc9915ea" "main"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4b098695335c89f
dashboard link: https://syzkaller.appspot.com/bug?extid=521f7e7e2b974abde99a
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=115f4d0d580000

