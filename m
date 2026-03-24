Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6613E3DAE
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349727; cv=none; b=Q7EV5hFXxQNE/TQR84y/NlJy+07vqLj8geWeJKmz4U4HLKYjFPg+PopH9tw14NM4OwrKUd6vGpsZ2T9H/N1mg3jGD9LeM7oR8oIiYmXPCaswmDapTic2zndo1065ziUWIt3W0R5Rez9qNOkYNWX81fsyTew9k0D4asdtKGgEf9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349727; c=relaxed/simple;
	bh=qcCZ95COiv96VvpYadORWAQhY14UQvlQK48ncT/J/F8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Q3PtNJheJAqtdcwiLyDHdZMB2y9BwFUlPdbPpncwGNiVYrSdrrNwoAcnYEuOAl7g0a32UVRWbEdy6E6bMSakNlVBsCpcDJspRSf7skUvd8Bqq19itPskKAD5ySJJ3IYkDL+j8yY8ocNzzMTCp7lnct1T59DY2wdpZWpTUaLrZb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62OAtJnQ083324
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:55:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62OAtJbN083317
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:55:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e0c7030b-261c-4ed1-b6b0-bf3b83a41d60@I-love.SAKURA.ne.jp>
Date: Tue, 24 Mar 2026 19:55:18 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Network Development <netdev@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Can networking trees carry temporary patches?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp

I was carrying debug printk() patches [1][2] in linux-next tree via my tree
in order to debug "unregister_netdevice: waiting for DEV to become free"
problem [3].

While these patches had been a lot helpful, now that easily reproducible cases
has been fixed, this problem is hardly reproduced in linux-next tree recently;
giving me no hints for debugging remaining cases. However, this problem is still
reproduced in networking trees.

Therefore, I appreciate if networking trees can carry temporary patches
(patches which are not intended to be merged into the linux.git tree).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=58b4f8f612187b0d9583b5549044734ecd7071eb
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=02fb7fbf5db47bf5c1736b692888232f5f6bf80e
[3] https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
