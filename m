Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C014F42668B
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986577; cv=none; b=XNvYzSbX9qobTZLyraaeEhMcakCdOv101BxQVCFUPbo3ia5cQdqCYEN1GM0fSIF39pomuKyrdx8YZwfrXIADGPyuiXe6/0lxU8YbpLAdMX45h8+5jX+XMk1GebegrAPXqsq/LuLKj/ITJDfzpVBBNFmKAyIGXmiMJWkQ89h2k4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986577; c=relaxed/simple;
	bh=4QK22JD6oH4SvxZHmOyYQJJkExZcrvgo8YM1Io2s18M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=e9kyS7SeVSiO7N1JvpoqGRWtIf3sYm8/kLXctt1SKZkKDY4A4Fbly/jFsNqBwb/eXhRZU4HLggdWGKCY2xdG0ghAPNrZlkSBc2KfPtBIZ991DfvW69HvNoj1jZGLCAXypph0dR4kKg7CN8JCgz5Z0s8JdgBsigTU1TeDcsdKO40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rLL5rnvK; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLL5rnvK"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3990fe066ebso5260439a91.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 13:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788986544; x=1789591344; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oN/gqs4AWaGEOYc4NXETn7MgtPOtvKlXrZlfFK+KbqY=;
        b=rLL5rnvKxJ7bimUEcTFKJMabTEqZECh1pV/CVR3V0vpTtduiuEKKDH14JkcVkTV45d
         1X3JNvE+5ko7Ihvn8ahXUTqh0ngrHVK5lGNB80LtJbLAepPvIcFM1JmR7W9/JzK1UN1F
         QC+5ddYNQhk08DFWGt7G5OQaH9Um3qRp0mRQrHHmRFt7qa8UGAFah9fq/kLcOrB6CCXS
         K3m/RvXf9GUkV0CAhd10bPKJeQQfoPS/bl961dDJcTFxHNdMW7YgaW/VsHBK8wB5jo9l
         5OM4Yn+MEKIM++DCpv9cDPEnmF631Ws6RY9dWAaTFUE1h13FdtksuMFYg0h4sKT5NAoO
         vVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986544; x=1789591344;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oN/gqs4AWaGEOYc4NXETn7MgtPOtvKlXrZlfFK+KbqY=;
        b=o5N1Z8cS2c2fXpZ5O94+Vpl1FWbL0EAt7qZLM9TZqYLGLlplXO+hz8lobiasNR9X4O
         ynb0+NhgbsocoVspjIIF+uPzCcFHDaubC4mCEpMyml+18uHc8eJKkxI+bcbik1XPW931
         98p28Fu/kGQ4sinP+ePxjQpfx6nVrkCQmbru+P3RG/TZ8uBxCom8SpY98pIoZHmk0qwb
         VQO0HCXflLjmyMQKhNSfC9hFCOKyNr+88tK0H//Vrm2zGfRlviR5HaGOuCkH4yzR3qDi
         Ifo57U6Ncx+tanoPy+Qn4R7ryLxcdq6mw/CjiTtNO2mKTshlDHkWnDoCad9veSGHEXAK
         e8EA==
X-Forwarded-Encrypted: i=1; AKwUvByKHgtOvL8pz8Xk6S90co35Xdxaf14A53xrE7QS6mobtIoeFMLwAF4bTAzW0fjcuyeqWY1Vtpw=@vger.kernel.org
X-Gm-Message-State: AFuF++kquga0yyQyvDM88ndiT0P9wYusPn8MdkqwLfu1K6j1iNx7fLAp
	/j6dpaOMa7y73ozDFdvgqmlKtUaF8CbN41L4/POqasr9M+HDPvDFp5am
X-Gm-Gg: AYBFou050vIbZ5ZWVWIG0XIoWMb1M+F9nZTKEz/oEAZpOC91WbvAiICAXYXUcoPav9h
	Mu81SLRpOcYFHqqIGnDrRtEdnxZKcpCOPv+GKWf8i4FlsOJyS+rAaZTFATeY1NWxGkJwB9tHYX6
	efGnVRPS7PViZqL7lOyLrNN6UzTeIJDQvlI/Md7PLt1CFnK7HbV/eXSpUHg2I5VzN0Sk2ezZd2N
	uOkL1jB9uNZGjqkB3Oyt06JHP6Agbis4dajKe4FMguHGjy9kzsup3F6MKKGbH2pvA4MF4sLbgla
	v84qnr3WKfi9OgvvFW9yXsgbJ4kxu2C7b/fEIJFeRhiRXFLYBC70p1B7eD6VgQ6HDPc7ExBNQa5
	4bg7mAWTwhGxE53EuFx/8YrqvSo4PETRgp+U9bonWrvtwU6GubYsv6axaRAJ7t5vIhLNg3ymt3I
	2KpEtA5+MaBRCt7SyuxuIAnjjV6Ox7L63P2vlUyqFv/G9F2uAWF/i7RAg1q8dWUNAhoUm0nLCxK
	KZ1jaB2syRwYnoCKKriomIyYliU6asyKG/x1z93HHqH5JNNmrwb2c8dkHXQ1ps6WpWk+OQqei7I
	jUgj3QnS7t61arNSmHWVfFi4WVd9wlWWBywjfx5isnD1MW5QdJEqKB5ziVVlF17bAaoRoOQa53O
	NzflAKv7tg5VJmRop41v/
X-Received: by 2002:a17:90b:578c:b0:398:e6b6:acc2 with SMTP id 98e67ed59e1d1-39b261e7649mr58879248a91.12.1788986543953;
        Wed, 09 Sep 2026 13:42:23 -0700 (PDT)
Received: from [127.0.1.1] ([43.227.225.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d770a010dsm1270437a91.3.2026.09.09.13.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 13:42:23 -0700 (PDT)
From: Nikhil Ludder <nikhilljatt@gmail.com>
To: Emil Tsalapatis <linux-lists@etsalapatis.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, horms@kernel.org, dsahern@gmail.com, hawk@kernel.org,
 razor@blackwall.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: fix reading neigh ha in bpf_fib_lookup()
In-Reply-To:
 <CABFh=a7Z=heZODVsXwisY3VwULDy-Rq1hwO09exgX2d0-KzgUQ@mail.gmail.com>
References: <20260909024011.1252694-1-nikhilljatt@gmail.com>
 <CABFh=a7Z=heZODVsXwisY3VwULDy-Rq1hwO09exgX2d0-KzgUQ@mail.gmail.com>
Date: Thu, 10 Sep 2026 02:12:14 +0530
Message-ID: <178898653497.1776876.10402414041023036972@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 9, 2026 at 1:18 PM Emil Tsalapatis <linux-lists@etsalapatis.com> wrote:
> Bot is right wrt possible lockups, please adjust the seqlock
> accordingly. Also please
> add your full name in the SOB.

Will fix the SOB in v2, thanks.

On the lockup: I don't think it can happen here.  neigh->ha_lock has
exactly one writer in the tree, __neigh_update() at
net/core/neighbour.c:1495, and it already runs with softirqs disabled:
write_lock_bh(&neigh->lock) at line 1384 covers it through
write_unlock_bh() at line 1524.  A reader in softirq context therefore
cannot preempt the writer on the same CPU and spin on the sequence
count.

The same pattern is already used by the other lockless readers of
neigh->ha on the tx path, neigh_resolve_output() and
neigh_connected_output() (neighbour.c:1610 and :1639), and by the two
recent fixes this patch follows, 57549ab90791 ("net: bridge: arp/nd
proxy: fix reading neigh ha") and b824059a673b ("vxlan: fix reading
neigh ha").

Am I missing a writer path?  If you would still prefer a different
form here, I am happy to respin.

Thanks,
Nikhil
