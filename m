Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605905;
	b=xr10mP+iLvQw4k1ModR9u+GI0/HaaWAHFGj5ZxjXfOxXkTdT4TvRjJc/1Ontd6wSTEb5
	 mN5wSpojNrMyNMkblzWCTIpWv8JVVTTkBdG36HHpc052/4G6trS2/rPpNpfx2sglSkT8P
	 xzbo1y824VUtpQHpx6oFibIoQANRss+AR1iwPovevS/D/FqbblHTBgeHlnzJgIw0erBL2
	 Rfp2ntgBAeVXTJgA+Gi0+3oB5Y31HEhSsO7ORTTtDqW62caGmEZ7iwqHn5nJUY06uCxBy
	 6Qi1vKss23k2kWlRZ1gOd/YhYJSdlmenQmbN7m/1Wwc6wndZgRqZMW+9X+RWQkeAf4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605905;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=39768UITE41AYlJNmfpyyvPGwvwyzs1lv13/2Sl4ptk=;
	b=sf6emkstZjCNoD4YJfV+rOYIgCb6u1/s5woBr45t0mWRCn6izhpMwNseNUKrdq0mQMtC
	 32o7MZm1qoVa5qVsFbCc7indmPcFY9BfU2QvQUpy77NvzPcnehvaNpzw7Y8UkPthUGed4
	 I2bWKbFPWgI90vhKjQJUq2zeyUj0WvZz41xq4Q95F3mwY5qMt0lTfDDe9UZk1wpu67/C0
	 tAXlxAFBgpxylJxn8bos8/pnrl4UmLRpxzebW1KUEYHqwxGB9KD9acxuuTra1MGkC94NB
	 I5niy5PinkLFRG6WCkUBOTRpoM1ZI1iFThK8hvKcKUTBA01wXDnKkE/E3fp4dv34EFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=tjBs1NjS;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6361606A334;
	Mon,  2 Nov 2026 07:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6361606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=tjBs1NjS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=tjBs1NjS38BAtrfje1DJWPRw4+z6Wwo3u9u32sz6VNZr+6QUU6DoakAcT6qeF0aIXXuGTg9A6Nry6
	 BB7OJ4kdyplzK0fymNBda57WSJ41OjDh/R5icyCFsNNA+PUaITdzoEIW7X2qM66eVhPbFpRGww4Vnt
	 Wd5/z+WBUbubn4zQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76ae84105156-8847b;
	Mon, 02 Nov 2026 15:51:33 +0800 (CST)
X-RM-TRANSID:2ee76ae84105156-8847b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [198.18.0.93] (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86ae84103747-c9362;
	Mon, 02 Nov 2026 15:51:33 +0800 (CST)
X-RM-TRANSID:2ee86ae84103747-c9362
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: Yingjie Wang <1075151112@qq.com>, netdev@vger.kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, yana06070@163.com
Subject:
 Re: [PATCH net v3] ipv6: reject wrapped temporary address preferred lifetimes
Date: Mon, 02 Nov 2026 15:51:32 +0800
Message-ID: <1793605892000.83333.5506952827930878398@cmss.chinamobile.com>
In-Reply-To:
 <CAMMLpeQKJO52qhba=G-ZudUA57iAdX4SOapOv7YuprBZ3FzM-w@mail.gmail.com>
References: <tencent_7A270291DDE5CD89DAFFE8A745D094D5BD06@qq.com>
 <179344707641.114606.12665582704521593779@cmss.chinamobile.com>
 <CAMMLpeQKJO52qhba=G-ZudUA57iAdX4SOapOv7YuprBZ3FzM-w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On 11/1/26 22:08, Alex Henrie wrote:
> Is there another combination of parameters that might cause a problem?

Hi Alex,

Thanks for explaining the reasoning behind the clamp. I was wrong
about creation eventually being refused as the public address gets
older. I had missed the "+ age" in cfg.valid_lft.

With an infinite-lifetime parent, cfg.valid_lft grows with age too.
For the values you tested, I don't see an age-dependent cutoff in
that lifetime check. Normal successful regenerations don't reach the
retry limit either: addrconf_verify_rtnl() resets the parent's
regen_count before each regeneration. Repeated ipv6_add_addr() or DAD
failures can still exhaust the retries.

I don't have a reproducer for another refusal case.

The remaining worry for me is retention. With a short preferred
lifetime and temp_valid_lft at its two-day default, deprecated
temporary addresses stay on the interface until their valid lifetime
expires, and this path does not check max_addresses. Your 90-second
configuration ages them out fast; with the default I would expect
many more addresses held at once, but I have not tested that or
measured the cost. The creation rate also depends on DAD timing, so
my earlier one-address-per-second estimate was too definite.

Thanks,
Xia


