Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793526688;
	b=gC7VPEzLlJuE4LKmyMkQJRghU3NgWzCxmn5YZdJMM3hIoMpcdJDV4XQu5WMR1wnMl2CR
	 GxOODMyeSIhCrvQy8GQEt60/Pkoc70vuv9rJ2eJEHsM6LRWZ+UDFu2Vdq15YsZS2Lp3qn
	 LqZWriCvI3ztpT5HSxufcXjITPkZj/QoV7uMpB2+d2+UeQ9yRrFVnwN5XzVmV+7NFFt0C
	 uXwxbQUjzuV1iV9lnUqoGcjWG0k6jupP4a4PRLlz/zJYmezM6HcWMcA/hg+f76RlDoZPF
	 Bc2wOd1TCqR9ObNdccabCYxVtUysW3MXpiwbhNtCtJyZVz0/HvA5E1iaRnEs2UDO2Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793526688;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=42mltXfOHa8qQEgF7vx2IvMlukJoJC4Ac1VKSCu6M58=;
	b=wpU7iYQA7fLYWlVJ3dPk1OyVyh1/+3Et0+5asvigVN/PUt+em6waaHjiPDPh2aRh+cHL
	 SfqEmC/9hzRI8FhwpXBXB5h4iMWyjBNKUmePUpEiiUbye+h+zWzg4zk8Fa6opNaeLZP6x
	 fV3sLMGbsvvPJgGSPyBNDa8ZWOCz9s2oj1ixDYI0+cz+B/zvqMebZS109vdCufz/Gl1e7
	 T779r2y07td1CDT9dYqUJ9pYluKGFJh9vPMVt2ehhXMoWSE6FWGlqH1HPkDQwX+feS7fd
	 yq7N46Bdg464xFONIOxi2nS7Q3mVObViJFUG5lSY1jIrbtOwIvZn87fMnXCW9oiRK+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Q34tkcKl;
	arc=none smtp.remote-ip=95.215.58.51
Received: from mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F11606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 09:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58F11606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Q34tkcKl
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+LcOo+yzU61N5f/ovbIqmgFP1ag60jqXkCX/q1zSclw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793526680; v=1; x=1794131480;
 b=Q34tkcKlbgVeEA19/oLfRhDgHn0n51q7h03Zi8nXZlWgq7chnBC8JxMgHoF3yzURkNd8r7Kq
 ZMOiKmnnKFcY00XKrM8yYOFkwYcoJ2KQtjfGIbBcb9qCWv579aNLAirrAVEuJpTzt+HOqAlzKab
 3Gu78SHHJJKCK5M/wwMhy+GY=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a8b3a4003f078db1;
	Sun, 01 Nov 2026 09:51:20 +0000
X-Mizu-Trace-ID: a8b3a4003f078db1
X-Migadu-Flow: FLOW_OUT
Message-ID: <7ce7a3c9-0e2f-4f01-a29c-f589f03f581c@linux.dev>
Date: Sun, 1 Nov 2026 17:51:13 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in
 nsim_drv_port_add (2)
To: syzbot <syzbot+b3fca27eb4005f0111f4@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, stitch@zju.edu.cn
References: <6ae6e3d1.7fe51036.1ecf7.0016.GAE@google.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <6ae6e3d1.7fe51036.1ecf7.0016.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/1/26 3:01 PM, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    36aad21d50d1 Merge tag 'ksmbd-for-7.4-rc1-part2' of git://..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=1332b159580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dc4462df6d1062fe
> dashboard link: https://syzkaller.appspot.com/bug?extid=b3fca27eb4005f0111f4
> compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1194b795580000
>
> AI-generated root cause summary:
> In netdevsim, sysfs device attributes such as 'new_port' and 'del_port' are
> exposed at the device level on nsim_bus_dev without holding device_lock or
> checking if the driver is bound. An access via sysfs after the driver has been
> unbound, after a failed probe, or concurrently with device removal finds drvdata
> set to NULL; passing this NULL pointer to priv_to_devlink() computes a negative
> offset from NULL, triggering a kernel page fault crash when attempting to
> acquire devlink->lock.
>
> full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=b3fca27eb4005f0111f4


This looks like the same issue Jiacheng's pending patch addresses,

new_port/del_port don't take device_lock nor check drvdata, so a write
after unbind hits a NULL nsim_dev:

https://lore.kernel.org/netdev/20261012135941.78329-1-stitch@zju.edu.cn/


