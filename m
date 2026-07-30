Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3A8432E98
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785431561; cv=none; b=qYx2jeD6hf1fFcAWEV37b6OEf5piWGWx2sRDISwre3Fa3M4qY+JjxZ2RktqljUMRZWcTjhiKNNj2Ywla7VSJjOiBDuhZmJ6Xi7qE9iOkxispseetA0TO1EMOUDkoAsBVvm2SbeGOhUlhiAFRQa4n0FqBFcGLZTBwbSSkvjyvOZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785431561; c=relaxed/simple;
	bh=irJiAlE0uebSDxrA7+RQHhRTNXJB7f3ha5b2+fbTaaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhLszwkdFakpv6O95uLpObDx7chK8ECt78r9jg2BkDflutkEX+Iq96fNxUSCmF5we1e6pJ++8f9381dvXoUv+bgdbdHBKwsqAPtdXEH/OAoHGVLol73vpMLNKiV8X/6ULMMwL6NP87zZrEq5CLqahyNUHN68XHGQti/Z1bA4M8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dq2z/vLK; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dq2z/vLK"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39c95395230so699831fa.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785431558; x=1786036358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TBrurJyzVlD1+XYXbZ2mHYJRmHHdubezJzBygUS+NMA=;
        b=Dq2z/vLKFv2pAyvVqe6cT8IHCZofQakmNLB8bMTy0j6GRFAPTJDGggQwKV7W1/9pwn
         54t31TrTNN8+CMH3d1xn1yDVObgbflTh2vLtVOQiPCdirZfsof7ow7mmtDMhM4tJiyIl
         YK30cSbHN06yS1hx39xfst8UEsWJG0MqpoxGHuHmHQ1DMFNDFzHYmjdSc4eO7IAHSwmk
         CZgr+L2AN712BIm6IOgD+2YaJ1oi4/mKYdVZnuyZriqnTcVVabNb2ywF/t4gPRUV9t2B
         sWy0KbCFkDMSlZhrZIG+OEfxvUVi7p/7ySg5yc9OFjJcnZ9sCuArdyL/brBohZPR0DFA
         3uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785431558; x=1786036358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TBrurJyzVlD1+XYXbZ2mHYJRmHHdubezJzBygUS+NMA=;
        b=iRO16dP0pbDrwUVsC3LXb6zibanP46RmBn8IkjDO3shzRI+HLymcDQLkfz/znbHAJl
         oaGkBI0NzANpT076L3eKGhLIgmXnUYG2FlTZ4vNo0ISFNBVmcW5lqgT9V2xMeeGc93WU
         BOj4tfD2NHE0xxhYhaFpkaabimciSXMOpx3Ur40iz7OFwj8q7Q6s/XQEJN3uUIVNx+AO
         Vg+V1oPDsKqleCQlSJ3qOyMT07KnVG/B4pjjYbfWzCyCvH5BmfS6/yUvx6TLSlEz6wqu
         QUPErrWEZVgsch+wdgN5wUh4hzASV5FBBBsHauv3Um5C4W111arazVGjNMvIPSKinDDr
         1fAw==
X-Gm-Message-State: AOJu0YxhlWbMiB2shOM+RAjJ4LdnDFALbwBrAHKUjVMrI00igJFBeQbd
	izo6dNgIDhdZIAU5lDYNUmGB/HXH1iHy2cUNoaNCgcbOOM34LNk3OU60oonXWw==
X-Gm-Gg: AR+sD10KvevrI+XESZPZwo6gpVt/ICymSua2EeAJ3/a7sUhPRX/a0oX+tym6Y3NaAYb
	oxt+gdtNWYO+a3iYUZ0xnD8n1APzQF5jJyhQTiQD+d49uhQZB7ojClswLy9J9z+mdAZeR42goGS
	34e8uAlmW+Zbxkxv12HvkioUP2sxobbrvGzXDh6IZwZp4Ze0MgFchi4HgQXpeb1Q5ugY4ce6tLQ
	tnCsnZLfHz+a1C8+kzYRSFzUyl86RZ4RpsfBAL+20nT2MjO86bUi+oLhjjPVUQ9BLfIiD3Z+2uh
	ZqeM5MlmxQ4vIxeGft1jBgB6PufPg0E3ngLoopjym1osZTxwM/lBH3vSbVuv6VFIwmRCuNXe253
	BlZ1oc19aDtXO/ipMdV8sc0qCEbI0FCAJFCZLE08GOpWsC2Ea2hLFtvEIJnx2iCVFPBZlAGYgiX
	ck7ijkf5L9iOirsbu8arT40GOWHKX/y8ZHYzubVwuBlA5ICkqy5vkiaVAPB/Y3vIV/bpgjaA0r2
	XvdSIhe+xv4efnIkaVYDLh5yILHLHK6cZfwPHTyLJxZgEbVUCOxQY3F7Q==
X-Received: by 2002:a2e:be27:0:b0:39c:92e0:528e with SMTP id 38308e7fff4ca-39f6b8171cdmr5519091fa.10.1785431558137;
        Thu, 30 Jul 2026 10:12:38 -0700 (PDT)
Received: from localhost.localdomain (46-138-176-102.dynamic.spd-mgts.ru. [46.138.176.102])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f6ac5ed84sm4288341fa.25.2026.07.30.10.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 10:12:37 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	chrisw@sous-sol.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rtnetlink: truncate IFLA_VFINFO_LIST instead of overflowing its length
Date: Thu, 30 Jul 2026 20:12:13 +0300
Message-ID: <20260730171214.76860-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0773587b-b355-46cb-9f4a-f3eecf8e01ad@intel.com>
References: <20260725132236.88318-1-iprintercanon@gmail.com> <20260729185513.52564971@kernel.org> <0773587b-b355-46cb-9f4a-f3eecf8e01ad@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 30, 2026 at 02:17:35AM -0700, Jacob Keller wrote:
> I'd argue this is a "fix", as we were previously doing objectively the
> wrong thing by randomly truncating the message at arbitrary points.

Our mails crossed. v2 went out ten minutes before yours, taking Jakub's
128 and 256, documenting them in the netlink spec and dropping the tag:

  https://lore.kernel.org/netdev/20260730090700.65867-1-iprintercanon@gmail.com/

I have no strong view on who is right, but the tag decides more than
bookkeeping here. With it this goes to net and gets backported, so an ice
PF with 256 VFs stops producing a corrupt link dump on a stable kernel;
without it that waits for the merge window. Against that, nothing
regressed: the interface has been able to write a length it cannot
represent since 2010, which I take to be Jakub's point.

Happy to restore the tag and resend against net if Jakub is persuaded.

Artem
