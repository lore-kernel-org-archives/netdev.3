Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075A81CF8B
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833755; cv=none; b=RF3hgPmr5BNAyoBc2jOC3tEIa/93DD8iYQahoBHL+hJ0BeT588mr63oicw50DykyFmyNxoyQ8NzaFWljK2QNXTTiOP/NFHmxIX20gYEH+W5N7IEU3mXfKmdH2hb5+pR5H6S02x2Ht4B/wEyoUbbkzLlHwl1jcOQKJ5H7NWpFfa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833755; c=relaxed/simple;
	bh=wuMIPaPYMwA/H4Nn7Fr1DJZGzW6lwArqv5Mbl5mPNlw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VALngkBu0S/FFqzRmQGJpb2dkonKQt6S+cDXM3H74c7npBoYbHgUScO7Wj8+FL4NGryYjMPZjVbhQJZW2zFy+3Dstk+Ma4VGTZsWyOL93ILL/KJMJwCgge8ibwmW/ncvAi1RoQa8dHCDZ1KB44i++tLmt1Ht/WJuIbbazXSnVbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMJc2SEC; arc=none smtp.client-ip=209.85.161.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMJc2SEC"
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-68a3b605bdcso1225345eaf.2
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775833753; x=1776438553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3C1PMNOmQXQIpC+R30y8x9xaXsBdXwYRfzfJfB3GtNk=;
        b=TMJc2SEC67KHcMsaPjbvmMnrneb/+ZdSSEKH6WJiFsfutsTH2zwxnCoj1vuVc5FwKb
         YaoUHKtFayK0mMTzckmAD1VtmtrKVJ5vxs1jmcZSwmG3C2D+wDKlsjSW+L7XXtWmwjdE
         U+4sxQMu6gTGHm/8PZd1hLweaDYEfiXAB6IKRp1SwIrbsqDvapZMdd5i6V4Cega3IJQF
         zkLOvv6MFThABEmuUv+IEgJ4zqpB9sfshq7n60Z0vodf8cKfoF9I38Sd1CjyxuCSlUHx
         kThEPHL3owQUoNzZy1RjXENtLG3MB2bSQA14cWpHEjMiq04AGJ/NLF3+0O1YoYp13Af3
         r3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775833753; x=1776438553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3C1PMNOmQXQIpC+R30y8x9xaXsBdXwYRfzfJfB3GtNk=;
        b=JGQOy4L6kpWNWSBZQ509HNUoNf6Sn4MdFhzLIu6JjgYyqrxv8MQ9JVhipiezF2dJDl
         O5FGlKefIbfae7h4NfiVIeJ0m9B1id5aIa3+x9GHq81cPwIRfwOOhDV7Y9SjYLDwjQ6r
         ZmM95kH33ACIPNPa8Ld7VYqKB61I/N9OrP5ziynuFxah6/b/3N1HY5Pwx5/A6bl1kTgq
         1gD/eo5XqX9JMBQWuX6fvM+ukMDfJSfxfhsTrg1vaWNlYV8HM0P6SS+AECMQLT18ArHu
         qsS8RB+pQ6rcWNRy7UAtUGzuFWCFbHX4fGcvJps0b7lSuXB94whVqzLjnkocr366e9o5
         s4Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUy2S51zDXYuXpSPQaxYIn9waPqDZfZfRrAxv/IkLBcTeEIBitl8nuDMdT+uxRj047i7bwBh/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6DkmMcH43gGhwyxaneZ2nmReusjYtneUOo/Q2BKw47rYkka4S
	6/WqaGC5rPd9/yJh2QVhEs3lTzc7Jl0cxGXJjh9NebwaLx7gZTtUn+0X
X-Gm-Gg: AeBDievu5uA8rdAZx5oHExEercssJPUeANZ3VTMNaedU1ryXjZsG4yrDxyBW+bNaR8S
	6BHfHkbOXpNyAA6Y80FVti4/wE6KsTtohUSOURkNElSlNH4y+av1hCs1hZRjZq9UGx98Bc504vL
	OijhLgBvVal71cPcyBLra7djQZ8cfUE0BBA7oA0xfXw4bVCGHNbVbz4TpEE359pT1ZWIW8uNEru
	HQY5obWAQ0zmDeGXh0hIdTwNdhmAgxL+6hvyMX8cgfr9JDgWS8ywXc5PK5lkuWF4smyylnwmW5G
	tJEEwsXdkSBXY48dcU66LJn92gofLbogt4f3X15+lvrmWkNbT9uUZKuiQwVqxLDisZaVkERQ/+9
	hoNgrAkF3BToTxM7d4g589TQQ7J9ouhBu5tRuANbVqdkEdGiLRlHkG1cYll4jiSUW0/+1c0pZ61
	X8fcONX7T/HAB4FGFbFw==
X-Received: by 2002:a05:6820:168b:b0:689:ceb5:6f38 with SMTP id 006d021491bc7-68be5b5edabmr1719084eaf.5.1775833752820;
        Fri, 10 Apr 2026 08:09:12 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:45::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68bcacc9931sm1577202eaf.11.2026.04.10.08.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:09:12 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Fri, 10 Apr 2026 08:09:11 -0700
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v6 00/14] net: sleepable ndo_set_rx_mode
Message-ID: <adkSflwfvJSQ1y4H@devvm17672.vll0.facebook.com>
References: <20260407153101.3694714-1-sdf@fomichev.me>
 <20260409204443.37c57907@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260409204443.37c57907@kernel.org>

On 04/09, Jakub Kicinski wrote:
> On Tue,  7 Apr 2026 08:30:47 -0700 Stanislav Fomichev wrote:
> > This series adds a new ndo_set_rx_mode_async callback that enables
> > drivers to handle address list updates in a sleepable context. The
> > current ndo_set_rx_mode is called under the netif_addr_lock spinlock
> > with BHs disabled, which prevents drivers from sleeping. This is
> > problematic for ops-locked drivers that need to sleep.
> 
> I merged the queue leasing, now netkit warns :(

No worries, will rebase/test/fix and repost!
