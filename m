Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF11514753
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793299; cv=none; b=KOV5zPihpnVFM84j5hWxWAzuyvMYJs2UvajSAsaVDueb2dSk0OCcPqrqYh+s+dayLnHuTSiwnsm9bRdDYHYrpMR/Y8Ps90DRRPEfkhn5q47J/b7bPaDAMcBGqD0LKXVXyN0/Ho9EiTeN2ho5XlUBqbc8cu8RETxf2Canf2J+fk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793299; c=relaxed/simple;
	bh=wmloewVcpcHaPW+zXjFWvchitKypkQUPUD54iPC2nrw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=U7uKi+JSz9P+bn23NEe8THFJ7Q7RzxF1zhDNcvEs/WKd3qs6lVw78tg+hevc0AcfsQnmuNHXWpWXF4XAfrHXVMvEe8E4Mvf33cX5PwUiqI/I7oi9lIzxsxSFiJ8Ve39bYin1hBs24HEBD72xoLQj3i+5HHD0aJ/f5sF5PaN5a/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFZc7I74; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFZc7I74"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-6729ca45e37so6132478d50.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793296; x=1791398096; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Txr2uH6VLruyLwaJ0ui9FYVNDJPa2Ryyi4B8kwS78z8=;
        b=pFZc7I74DdQgoo0zOB3BauBb8c+pd0FQjvqiDUgKBYM9yIupWgaYjudN9xf53YogJ5
         TtUqm1az/OMi5KWW2QxgAQvi/pXwRFG3Bp3lhlOBGJKYqZJffaodF6bw5f28f50XdsP+
         wUmun/GIWDbb6MdxUuS28YkZ3MjkGHd8l9x4mRbpVY7nOqqrsmNH9+C+prUk0HjwimR7
         kgKIyATouPKHpvKHcFR2AbWVasthYB8GKbYe/X/RIF5eOwhGHokz2n5skrlMIU3mLOnP
         6z6ZWqZ9ZJYYyNHCPDi7WPnEXJUAeylO77rHbKbKEWr7ah1Kv8jDK/4aLehV0A+IyxDr
         +dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793296; x=1791398096;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Txr2uH6VLruyLwaJ0ui9FYVNDJPa2Ryyi4B8kwS78z8=;
        b=yK/wsrAZOOhbqKxzc1Ct5FcZahxPqKH2XIO22yu2Q0yy+2ZbSSk6vJ/0nmP6a6Rl7j
         6lZENVhDdo5LKFI9gYJ2pdoVOOh4ADmJbyf+3KUxnNL+k08WSicBJdGrOvLO4VgFpb83
         tCC687h4/YKwgTnMhTUCB1bStFdaKv4nIDMEaNEW634kfNOIpOSMxVrgHyQBs1xQ6m3p
         UC+KnuhFitYrxfBdFKeyir8FAO+MUwHwU3t48ZJCtYM2Hek4NBo6tu0Dly3YT6W/Z2e5
         AQEcZVnsyRNY3o+p2pvsrWxxPtEVrkz3+UA1nHINA/72HzClZaENd+XoLiTHDB9ni/m+
         /9hQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwnDqehMTzhiIViCikAYFHpbWMjYXu9OmpxblJPG74YzJz9buZE9qjOmIRNt9eXvVHQHMqXnI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJ/PIt/pGQ1MqJEr5Q9yaBwUNaMiOJI3xS27lwZkATxVj8dnG6
	8cd+o3drE6RuYpIoOb/xHkr2pjX5XWePfSbZKu0fcUjL+USjB+HqFXs7
X-Gm-Gg: AYBFou1uvWWscT8ERvmkhWPxhDThloJZvmp13GsSRzZDOHgpdCHqofdn2hIHp/Qnojg
	vNIPX8Af4Q3JB/16ZKKxmyDWpAmpo6yhRaepKxPDbkn+5X68FA1oBJrhJi08RwV6+PkBteqP2sr
	ssqhIquv7DYrLOMiNChSj9RmquqVGbK370jlfdUeIuoMX4z5SWE4Y+sk7lYIYkCkxVCANDjhzg8
	IPL1Fdfeq6/vNS1XkH5mteluylxcfDbRuLums+BUdNXLQ6Fl9uz4pt/e6zjpToHXdfKV0IFgx6g
	zE3e5dfwYB6BC/Dda14vRSJgdLuW386CRBKMhQ1oHEnciR/TUdpNtL+soWOazEHO4QpKGJTKwFB
	zW/27QLEe/ok48UVMAViBarZ6uiVlQ63Wh/2UqufOcVvTu4apI2uDLrCoua9YH37aaX2gXGYMRD
	A0sFqTfBWCRJrc45wbRPxOCjSr5Ajbig4iKgKoLnY+Eyib0XLcqNkG8/6WxsQ6vURHx7i7tQuUj
	CPhZsAqwtuBjCWrs3pBK8z71zTttCnvcDRxvxfL8/Yy/aNpVgiA
X-Received: by 2002:a05:690e:169f:b0:674:c0b:346b with SMTP id 956f58d0204a3-676832e1ea3mr1161182d50.4.1790793296478;
        Wed, 30 Sep 2026 11:34:56 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-676918703bbsm148648d50.13.2026.09.30.11.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:34:55 -0700 (PDT)
Date: Wed, 30 Sep 2026 14:34:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Rongguang Wei <clementwei90@163.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 Rongguang Wei <weirongguang@kylinos.cn>
Message-ID: <willemdebruijn.kernel.23ebf894fb51a@gmail.com>
In-Reply-To: <20260930080746.135017-3-clementwei90@163.com>
References: <20260930080746.135017-1-clementwei90@163.com>
 <20260930080746.135017-3-clementwei90@163.com>
Subject: Re: [PATCH net v3 2/3] tun: fix inverted error check when
 re-attaching the filter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> tun_attach() returns early when sk_attach_filter_kern() succeeds instead of
> when it fails, so a queue attached to a persistent TAP is never published
> in tun->tfiles[] while TUNSETIFF still reported success.
> 
> Fix the check, so that a failed re-attach aborts the attach, and detach the
> filter again if a later step of tun_attach() fails.
> 
> This has to come after the patch that keeps a kernel copy of the program:
> with the check fixed but the program still read from the caller's address
> space, a re-attach that used to succeed without installing any filter would
> fail with -EFAULT or -EINVAL.
> 
> Fixes: 54f968d6efdb ("tuntap: move socket to tun_file")
> Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>

Reviewed-by: Willem de Bruijn <willemb@google.com>
