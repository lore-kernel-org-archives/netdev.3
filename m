Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794372352;
	b=LKGMzNjXLbPJMEwpTclQ+KohEbdvgIdykb99NV395Ar8vAFJKTFQ7Kn+JV7F4zX0ZHMw
	 GZF+kC6ejRyw9hMHH3aeadYoHoQCzGPyX5a9bS1g0id9ylVMpxzVsvtAKkJ/udK1+fgW9
	 yNNyfKwsYRLUUwYrkSK68BuRnKlKp1WOUQ+Rd43Q0WUSVpEFM+ttns4STrNCwTVukZlyf
	 Cf22vRN/0WwFq/r9gfpb9SBaQN05fBoHLWVwhjerPED/h7B+hI+e++oJXPPA3CAlyJKud
	 7dsddMolHTjjanGWLMwrEE1DYVHBwxvslvZvrU2EPc1zuhf1hxUTUyOH/bnGV0dNaow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372352;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QihW/6Enmbr2pJagUmwIuHLjXObwQ7XXA7JRjeBMr20=;
	b=s+lr9GKZzpu9AM1Z7W7Oz8/x1GFhmkBtgHjL7DJpBb+wtVgqSDA2HFdWPYnpfWcDklj/
	 2RFN9kOFe/YMD2fQcvnfHgBt6UZvpQVXv5mJXo7EcIerEZV23h1/cNp3uqqu3BGM2ODNR
	 92L93Sggia2lOVJ/YItmefpwsgPWCbOkL6BJf7KI7rteR0C4kMflVFt3Qg87dB/iqvjol
	 5u3Q9rtAA0cFDJ1XOSOThHt6U0TgxFx2uYcuDl02klG4yoOi4IT/kEVu9c14YDW/7hXH5
	 TMdMt6i+QI76NzQ4Sr90puaFB4l91/rF3qmFlpshPBB+B9DTlBvqWuTcxFN7I+ZOGgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=XmnuiKDa;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A7C606A327;
	Wed, 11 Nov 2026 04:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7A7C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=XmnuiKDa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=XmnuiKDa+irRScHJeAQ407Qg8eRyVnqZEtGyobhUKrQpvlj84Tdj8l1nIGosOQg6Cpn4u97cPaUhx
	 lV1h2S9yB2qHg1AQiZJeD8M42VyeFVTteRDLXOt6ETOwh/Csf3OfHP9e2a//UmQlkH0iQYvxn0onEW
	 /OHRR7IlsQCnANpI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af3f2fd437-742bd;
	Wed, 11 Nov 2026 12:45:49 +0800 (CST)
X-RM-TRANSID:2ee46af3f2fd437-742bd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af3f2fb415-ce5b3;
	Wed, 11 Nov 2026 12:45:49 +0800 (CST)
X-RM-TRANSID:2eea6af3f2fb415-ce5b3
From: Jiahao Xu <xujiahao@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Oliver Neukum <oliver@neukum.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	David S . Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzbot+1994e2ecf323ed90f255@syzkaller.appspotmail.com,
	Jiahao Xu <xujiahao@cmss.chinamobile.com>
Subject: Re: [PATCH net] net: usb: cdc_ncm: don't underflow the NDP room check
Date: Wed, 11 Nov 2026 12:45:46 +0800
Message-ID: <20261111124546.992581-1-xujiahao@cmss.chinamobile.com>
In-Reply-To: <179431970794.994134.5397680174063039863@kernel.org>
References: <20261109060913.526268-1-xujiahao@cmss.chinamobile.com> <179431970794.994134.5397680174063039863@kernel.org>
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

On Tue, 2026-11-10 at 14:08 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Medium] The code change looks right, but does this paragraph describe
> the trigger and the root cause accurately?  Can a second datagram in the
> same NTB reach this check at all?

You are right, my description of the trigger was wrong.  I re-read the
code and your analysis holds on every point:

 - cdc_ncm_ndp16() returns the NDP it finds in the chain when the
   signature matches, so on plain cdc_ncm, which always uses the same
   signature, the create path here is normally reached for the first
   datagram of an NTB only.  An additional NDP for an NTB that already
   holds datagrams comes from cdc_mbim_tx_fixup(), which uses a
   different signature per MBIM session.
 - cdc_ncm_setup() clamps tx_max through cdc_ncm_update_rxtx_max()
   before cdc_ncm_set_dgram_size() runs, so cdc_ncm_check_tx_max()
   computes its lower bound with ctx->max_datagram_size still 0.  The
   bound is therefore max_ndp_size plus the NTH header only, not one
   datagram plus one NDP.
 - In the report, end 0x140 = 320 is tx_max derived from a device
   dwNtbOutMaxSize of 320, and the 256 bytes already in the skb are the
   12 byte NTH header padded by cdc_ncm_align_tail() to the 256 byte
   wNdpOutAlignment that cdc_ncm_fix_modulus() accepts because it is
   smaller than tx_max.

So the reachable triggers are the device controlled
dwNtbOutMaxSize/wNdpOutAlignment combination, or MBIM multi-session
NDPs, and not a second datagram on plain cdc_ncm.

v3 keeps the code unchanged and only fixes the commit message:

  https://lore.kernel.org/all/20261111124156.637661-1-xujiahao@cmss.chinamobile.com/

The Fixes: tags you asked for are already part of it.

pw-bot: cr


