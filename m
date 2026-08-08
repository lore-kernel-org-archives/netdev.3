Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E3839CCFA
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218238; cv=none; b=grqQf2tq0CVYhH3jPSFbP8xkh2KfIDc4fP/rOXIxw3TCWlexDx0JLF9jPMVZPDdlUPuKwj9IUmpYcafsM11v3CzMFk0bbEU2Eo/32/kXizooEL7wHCmmtZB3n9qokfGYDz0X/akg0kU8BRhcVXfAi7EINyAOwUSOH6W+xwyYQGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218238; c=relaxed/simple;
	bh=xjuAQz7VSBrZUXr4Qim7eaCsxevzN5sk4XPZCmcgkCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJyAVu7QWnU1EhgWmvCJ45wwG0WP0DT3A1dZCprwa8yBI9qrqkRnkskJZlt58yT/99cY9CpVAzTRG5cQ6uUc7lwV6fOKMghSTWiJEE1X7D9WMxo8FmdPlfirNCSnoTRK9qKNeD93NGI/6BBnMKPgGnU5eF4wNRmPF8khlwUFSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=eFWs6p4T; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="eFWs6p4T"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so495015f8f.2
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1786218235; x=1786823035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=reh0WLx5n9bqEjEOwxCRA1XODyRksj/VupCL85M155A=;
        b=eFWs6p4TvF5DjNr5VEv4z+HF2DMsL7WLhdNpau333GLQXc7yisN5eRI6R9HHgpi6RL
         MViloau5ABoCFO7waniDh0gBF+JKhlfYxeNYUyzL2yoy2tkGkrZVEL7uwZgPDs42Rn8/
         Ect9FJz1WIMJoR6oAHXXwkf6EO7sRWoImY5/xPD1NvVPdQpoqLcwgMEAeGzFUNdyw+QO
         3NkdGJyEKBWxLUVSDtUYQdMlZDcyBCAZebBhopj5OEN1tv3z7gzKl7PJGXzG3SvO6slf
         M334xgsub1JYsYCZiB9m1WM+YWuglUFt5Rb6XjpiX9x02v4gVVzhtmZt3iiMVdGq/3DR
         ey6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786218235; x=1786823035;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=reh0WLx5n9bqEjEOwxCRA1XODyRksj/VupCL85M155A=;
        b=Kjc5lo6mHhT6KMWJbUuxRB4ucVmlHm9SholDtixkW0KgmdByjnyA4NWgZ7PRVrpqEl
         NJffFzvvvx13ev8+N/zlzZYz9WdjqNEuK/M5Ul79H5B1Yvd116e/NK5DqQTiWF4E31UM
         5Jo2f6F/kQtTyjEcZYOhQRN06I/lXb7haPt9bl6EibuMInxqJwwrczyQrg051tbpB0H8
         aA3RjwWyKqfZV44N57S28fQmgIEglv7+zJzIA0eC5QeQse+DgRpuS5DIYtlo/YvssCBq
         oFZ0qKkon6DFP++mDB+h1z7UVfYsFsLfJ4u6LF4fi49NiGUFbuqAvuvwpZPbgqmz2kTP
         IWUw==
X-Forwarded-Encrypted: i=1; AHgh+RrTJXYXKz4Q8GiH/AT1kEjSvvBuJsGLDMmkVAoWcLS9UhQppe0r/MBHFj+mbAWV6HHdbEwej5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzne6aKSF4bGYP5+rwxbGMXL+3DhTa8Lotn9Om7xJHewTg3VL76
	guvzBeQbPH64kHbss9m+cU/LQgDIcMLW1siEaro4PdJIB6qteXr4xPuUuv14heed7f8qPhA0UlQ
	Vh5tCxRc3ZwiV/jkXbnuj2Nf1d/vn+Al/87Va+HmEFZ9+piQT95U=
X-Gm-Gg: AR+sD13N/PgFkHNZ80xrEyAmi9OLob/69OLHITIRjMPVPuapyrWl4dT3qAjYiUl2+is
	Nmw/ZXSmgbrSnJmiwKq/s9+lqqG/9YvJ0hLPTvjwdedO6ecHgNzYdG8oO8aMZijY6sBWqjGyplY
	Ok/wddnx4DLSSU9B3eYBQksRBEU4xyKUcORcKGGPh4cBDM6pAHo9f8tCycD3losfZ5d0yjgmwTI
	uhesAmZY/U/wIv3NBHw5PzvXGC2kbXvS/boNDoAgvkB5zse2rHRzDMuE2JlsanZAH/TBfCoQbaR
	uMcmEv+dYqCopQiDmdW3YoojUGPMZloNM5aK9j2dv3sLbeeDSlCi+Jv0ITDK7Sfhm8QtI3M26Wg
	v4B0J0dHhT8C5bMshEuI7tT3w4xbWwXLDhZAk2BFOuH7f6/ykHk7p+7in0QfBCvUlDeZSTKzi2s
	/zELpj17HYtUIS+l9Dek6ot/t8Rwx+Xi8KGtkQ1d3xbcFz8rkB8uM+5XQcE6tcIFtOPcgBfWr/g
	JKXNxLLAe66xIJ7pXG+jLMF65rSgpLSlW3UTg==
X-Received: by 2002:a05:6000:4021:b0:47f:9176:da23 with SMTP id ffacd0b85a97d-48130c04453mr12526791f8f.0.1786218234829;
        Sat, 08 Aug 2026 12:43:54 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:7b3e:3878:d9a3:4ff0? ([2001:67c:2fbc:1:7b3e:3878:d9a3:4ff0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145839sm16946528f8f.7.2026.08.08.12.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2026 12:43:54 -0700 (PDT)
Message-ID: <30dff1e5-cf28-4a42-9cbe-ffb7319c33d1@openvpn.net>
Date: Sat, 8 Aug 2026 21:43:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot ci] Re: pull request: fixes for ovpn 2026-08-07
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot ci <syzbot+cifb58fcbd8413e765@syzkaller.appspotmail.com>,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org, pabeni@redhat.com, ralf@mandelbit.com,
 sd@queasysnail.net, syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <6a756ce9.01d0871a.3a0d52.003b.GAE@google.com>
 <937f09b2-cd5f-4352-90dc-dad67ef8ddf2@openvpn.net>
 <20260807153529.79fdd152@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
 ifS0+hzvnPVD9wXa9kdjO+0H
Organization: OpenVPN Inc.
In-Reply-To: <20260807153529.79fdd152@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/08/2026 00:35, Jakub Kicinski wrote:
> On Fri, 7 Aug 2026 08:37:39 +0200 Antonio Quartulli wrote:
>> Will get this addressed and respin the series.
> 
> This gets triggered in your own selftests.
> You should probably take a hard look at your CI setup?

Yeah, sorry - I must have mixed it up with some other unrelated warning 
that shows up during my VM test.

Will make sure to double check them all next time.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.

