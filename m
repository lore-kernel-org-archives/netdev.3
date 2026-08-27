Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7414A3CBE6F
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818784; cv=none; b=MkTLvFFx3We6jQreejZixitTjy17TyvefQFMVhAzTn7y587b5DoLu/6jTuctpmnjfBYoCoaIGWH+FYfsznjPiU7vfQ3zB1Hl3p3LDfpBtAJztWNwPK4H9oJ4CloBEfB+nMkTd5y0B5+hOQJO7fJyD/NeiGxMgbYJn6hgKufiPHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818784; c=relaxed/simple;
	bh=/2CgVl31wv4sSObo0af19ir9kjm3WN8DPIOwijvUzqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QutDtz0+lQju+pZYwD5AJqM/PspNAR6tSI/b4RXYyxcEx3UOaGpdF7fPs2bMis3mNEOmhkuC+64fR1N0nN6EUq0TExObwHlCL0n+I6zRRZE3m+k8N1vA8fX5WA47VGZ7N1p/BgkilcwpB4XW2zSJqlQ3+WvrTbDeXtJbGGIsjuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQossVzU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVl7y00V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQossVzU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVl7y00V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787818782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pT8QHmdIgh8C/99Uph+9sWbsTLGNaTSQ6OcKusUcL0k=;
	b=ZQossVzUDsQ+vVemwjvQ7xYZwIW9Z8Y+2xxXDDTppueh9GCRwlWdgSJcRRPKp/z6gdm0vL
	QgQS9ZQjaq8nEZELPsqxMLe0zM/0Vx+KXy/+O++qmDPibuVngYEZH+kA871Udcxj3ECeT4
	Qivv3llDFK3a4ep49en/a54PPePu9tA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-_yTHGtUaOqyce5SqmDwpQg-1; Thu, 27 Aug 2026 04:19:40 -0400
X-MC-Unique: _yTHGtUaOqyce5SqmDwpQg-1
X-Mimecast-MFC-AGG-ID: _yTHGtUaOqyce5SqmDwpQg_1787818779
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-499b99a8a10so5750295e9.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 01:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787818779; x=1788423579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pT8QHmdIgh8C/99Uph+9sWbsTLGNaTSQ6OcKusUcL0k=;
        b=GVl7y00V6DnGXeiP9lF9dx+5looE7eYNhowv8GDUJsXVGzyPzc0om+BoBLRtLmjNeF
         xmjmf3VHV0mzelv6GgLI7eQO70NulhK9LHtbPpRdPETLJcFxwxymNJJC8BnVwaY5J8hm
         BmbEfmFnsOIegK0hBakIMAfXZFEH5Fd99rnDHTG6b5uc/Xko8SMdy4oABv/RrPHLmggm
         noTHlenQUzaMrHPEgJSTqbRlhUey0OoxOn731yptFKZXzCltH+Ur6HRn9b53P6gvwmhP
         TwcYi0MWjnLbFdaANvtmVV7hdI7K1V0Oop805hwvoHbDT4LoXG4bxzU09OpEiKgpmT2U
         w2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787818779; x=1788423579;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pT8QHmdIgh8C/99Uph+9sWbsTLGNaTSQ6OcKusUcL0k=;
        b=hg1ARmV3YNBbxNCmBBC21zZiWD9f5L5J90m++/d0oCwIQjaR1SfZS2YzMPx1JUMDUs
         EbqXLl1TohGlVJhF8hZzHoK7KRQqAzRmaz0EH+FAGoZa1dRodzqef3MFS2pV43JzGcHr
         aTfysUKC9uuUMYLhy1bA9UGnRKqHSuwdpiy7f8YGMmj2KMZ+KL5sDXjXTOEZoquEmKkI
         h3vc3Da3fqKJaoQXYKrgT+ABPRSfjMZCrayS1mWiehKlT9ifpjfmedupt6QerUwRdUIT
         WDxx88tFGcqBrhcWkfPN0qnkcyy3aRChkf1phpKW8OATT7NuWhWaCUiJqasSBuhJDUMg
         Jj7w==
X-Forwarded-Encrypted: i=1; AHgh+RoNjEoi7JNVHP0hE6SkFIlc8jvVD25iSRK+Kp1R/qI4sGX8827Jbx1Z88CsbcNrH6iI37DIupo=@vger.kernel.org
X-Gm-Message-State: AFuF++nhcHhlOY8VDW5VED/SJnKgwu1av+vSAEPuDuzD4aGSYSbIPsK7
	7U1y0STQBS2SKF3jbk/o5456FKxtE9bWl7XCXgtiX9Rz6HkBjfcGxVK36ZSune9ZgaxBZZMslEO
	ofLK4B9SZnnpjkNzNWfaJMXYng2n26SkPjTzXcsT7m7tCBL9A0p2Tf7RN5YL5cUndxA==
X-Gm-Gg: AR+sD10SYAH99nhlC66RugAI6Jz9WOysL96fVovwp93TPC6iMJ4CfhLZj04E0y+mw7Y
	1oUNocM3BtB8+pmoUjMfDpEv12gYWKaq4InasUwlvyY62lzor+yfD7QVSnod+cQ9SH2i9XSEU4f
	Fd4v2SpBqx2FZ/VktOTQtRGNu+sKcJ4MrYdcT07NSwa1YJVgzqKwS9LUhug0TpKOEP2JU//Tlrk
	3ATRAa6L5f1ak4fckvwMwKRi+7xJL2UsXVE2dxJXGkPGNXKwIjTVgOftzNJbxh/sDOGTb6zOK5B
	kjFYv9TQTeQSMzETRwoCtpzDZrnZmcToQbr2ZbbH9n58ywvehfNAx0f5UOhwA+yRdEdSUMtm6/a
	03DeXLy4SrrTCo5yfuvUNBjDHTGqRI43QEw6ukQAn2kYw+fCkHFRJ19PJ2wJZnT5y6CrnrMk=
X-Received: by 2002:a05:600c:3b25:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49b0dfcd4c2mr46298655e9.6.1787818779472;
        Thu, 27 Aug 2026 01:19:39 -0700 (PDT)
X-Received: by 2002:a05:600c:3b25:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49b0dfcd4c2mr46298095e9.6.1787818779033;
        Thu, 27 Aug 2026 01:19:39 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b0dd3e148sm29013275e9.1.2026.08.27.01.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 01:19:38 -0700 (PDT)
Message-ID: <ad731f07-3b80-4d48-a6fa-c0e405eedefd@redhat.com>
Date: Thu, 27 Aug 2026 10:19:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 0/3] net: phy: mediatek: support EcoNet
 EN751221 gbit SoC PHY
To: Caleb James DeLisle <cjd@cjdns.fr>, netdev@vger.kernel.org,
 ansuelsmth@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 daniel@makrotopia.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20260826202103.2280645-1-cjd@cjdns.fr>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260826202103.2280645-1-cjd@cjdns.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/26 10:21 PM, Caleb James DeLisle wrote:
> NOTE: This patchset bases on https://lore.kernel.org/netdev/20260708102341.53919-1-ansuelsmth@gmail.com/
> 
> Add support for the EcoNet EN751221 SoC gigabit PHY, as identified by
> product IDs 9451, and 9471.
## Form letter - net-next-closed

net-next pull request for v7.3 has already been merged, and therefore
the net-next tree is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


