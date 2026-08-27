Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860F2F7AD2
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787873774; cv=none; b=V0PLRgcBvFpQBdVUC90/xoN/tpgnUtprsrbGAqd3YJgQntj2Rm/TY/tmoaNOQk6cqbjFsdwi/3SzsuT1103JjS8CmRK1V62gLqzzrNewQv5OdCcU723/txpU/n2km5zclmFhrpdC8CKpmpbphqNr2ORK4rZssw7rNEYvBAHLoCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787873774; c=relaxed/simple;
	bh=XTQLGcR3T+FCgbuQUWCruXGoe4VfH0XLf/K7HDZ2r1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cjI1OYJEO7IIai31xk0OzaAEyIFb3BjFXyXIWtd+BhRK+BEJs8mN9CwpNzQnQczI+lObPD34pFJmZv0y5Cn8GQdTfWqK57FOZIQE4119kpxwQX3rh9+FJcOmdE4OMKGt3C9W/hiXUEGbu0mxOSRhWQ2EmAwFjh9CA6si3Wz2Mqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtIENhes; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtIENhes"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d712281f8bso4782505ad.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 16:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787873772; x=1788478572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kf6JULue6KdJKxJejpX7OoZpqQfA/4cqzePyQZ+hPGU=;
        b=HtIENhesklGIzXsZB0/sT8a5q8KUuvMVl3uKNt+T/7iwO1r8l6jHY+VvxVnD0TZTqJ
         t4GoNDVE4D0XjXTnV26cutD0ZT6cMNn+7S/VIuUP4EMC2bjHMktGf8JN9fvmnVAlVZfW
         LcIhVSL8LFR3BpmUgI0FXWZsqSuher981TGNEzJ1t8Dp1fsp+ZAqTkoXOlYpKzvBV5N/
         O68ahE0xIckdflmwCANwApYPZHOdU8J/oC4RGfhxnjvgOK9CPq+eCk6Z/MS60Jz0Q2l6
         tYf83YpB2PNXxR7tvOJeJ2EHFnOLHCvQZXMYmyMtCZuf2iw1aj3tatQMLBhI/+GhoUGa
         Fpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787873772; x=1788478572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kf6JULue6KdJKxJejpX7OoZpqQfA/4cqzePyQZ+hPGU=;
        b=GyWuDQvbRId6TXCDjI77G0E24O+UpS1deuL8cbDdXtXLNVLcA5JGRvun1DMBLys0Mh
         0nDxH3AakxKpcSqgujYbSRpjHDyPRcnIZQQxCdWnOIEIrTQ/olMxTJPGkhzE6UIfstnS
         HMzRg+WRDntKV3zx0oaimLeKqF5Q2ms+pbLxfHECrXKjgYLZ82esa02+Nhkj27iP8qD0
         8fit4N8/l37LTa6lS8QuVd4D3Z0Z3HAn5k3PSPlZ9biJijl8hzO1sicW1NpFLTsfXwbV
         MucspqIGcj2aFzWvkyFvOK2FVnQd6kCrTC37W5Q/CnxNe5dmvZqi6zVj9MFmumqmpyd2
         WFQQ==
X-Forwarded-Encrypted: i=1; AHgh+RrwD78dsQ0cxtJEUL41W1gtSfX6ZwpdNko2L6Epk0wlF0DeyhMQlrjq9MBSM/gwfvQtZI2VfGE=@vger.kernel.org
X-Gm-Message-State: AFuF++m1jXXkoZUDiGgWXvVc04dY88xIpBOAlObcpM8fQD7/Gd9DLs+K
	6a1eUdSo6S9hPr+pzKxUGOAkYSX92QiwGACjNlE+UA09Iin8OXYdZzMF
X-Gm-Gg: AR+sD100yBumjkcW8LC8nTO8hvKH2HpjmWfoTFncnXMEmFIDzxLYb3HAb1aCpj6xtk0
	n8sN5lQcsX5KKfDV65lwW+Nyw5LXicMOZDHtM8yPg/PKvyFRax4Y9zQYBdU8LAaYGkx/4JTlEHP
	bx70KfpzzyK4kYUCx9wmBmtw2oXbPbjd56XLQbQyd/O6N1SPXFZOlFY47KBpIeFJ5ZhzPc9wHOP
	uysTThpzv9FotohPkknOMkrf2hGbdvx3H46ib+9vZROFGZZoKlYT/CwnmJwDkUSROZsegjFlDJR
	7UhK/0rEY3Mfv89ylR1MX0FsTkkF6L1qXDX4pRzpb+mCj++ANSEJ0ve0ijo3ruG22rXr8pvC8DC
	Rp8HeLTLDP/7OVJ46CqndViyEoDnR8gzWyzwUK8Y9lX6glq2esk/CvVctds46h6vD0Y3j9YZtI+
	4L9SnlHXHjFxOFjgKFV+AEJCiFkKWU9SHB06yQssxXGcfxZbfqEuzvYrlILS2TGFxgnbHAJfl0K
	s+dMTT7N/WwKpAekdlrzEeoG67ZQkwbQI9WXFeaLnhoAUYKXogzoVO27yRg4/kVfmK9bFVVzaSO
	PEWP6UYIAK/b59PFXRqRNrQRlmsQd3BTe/WWBLOJA11A5TEUVw==
X-Received: by 2002:a17:90b:2dc5:b0:395:4290:46e0 with SMTP id 98e67ed59e1d1-396d0e83c28mr5526530a91.5.1787873771994;
        Thu, 27 Aug 2026 16:36:11 -0700 (PDT)
Received: from localhost.localdomain (2403-4800-2450-5401--2d10.sta.dodo.net.au. [2403:4800:2450:5401::2d10])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d1b38esm520403c88.3.2026.08.27.16.36.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 16:36:11 -0700 (PDT)
From: aslan.jnn@gmail.com
To: David Laight <david.laight.linux@gmail.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	netdev@vger.kernel.org,
	Thomas.Lendacky@amd.com,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v2] net: amd-xgbe: support receiving packets with bad FCS
Date: Fri, 28 Aug 2026 09:35:27 +1000
Message-Id: <20260827233527.71620-1-aslan.jnn@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260821213646.7bbb94d6@pumpkin>
References: <20260821213646.7bbb94d6@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

I agree with your first statement. I've just submitted the v3 of this patch
which removes the DCRCC unsetting on xgbe_disable_rx.

And thanks for your input for setting MAC_RCR non-atomically like that! I
didn't thought much about it before, to be honest. Will try handling that
on the next submission.

  James

On Fri, Aug 21, 2026 at 9:36:46PM +0100, David Laight <david.laight.linux@gmail.com> wrote:
> On Wed, 19 Aug 2026 19:16:56 +1000
> James <aslan.jnn@gmail.com> wrote:
>
>
> You can delete the line in the disable function that turns it off.
>
> But, really, you should be setting the required MAC_RCR bits in a single
> write.
> Doing RMW sequences on the hardware registers for each bit is really wrong.
> You also need to start with a known value for all the bits, otherwise
> 'silly' things can happen is (say) some bios boot code set bits you don't
> otherwise change.
>
> 	David
