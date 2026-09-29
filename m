Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAE523D7F0
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640731; cv=none; b=Q7fDOJyLrgo6qNU5n4xxLsmNzoMfs/mVwyqC+nVQQFBqkFvlqK0DJx/kDlHSh+k2SqzNXT/I1oXFXVKd4eKDaHGIJdngmmPG2ugQSgLikZclGBFATyZqwD7NoN+17WqOfptrtgnH+KTV0EEHdNwG8TRAotGLVxBwNLNuLYsknPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640731; c=relaxed/simple;
	bh=Pzs/2H8JRIHvRetc0eSOxZTr5wzjgXHRsjatXDajVME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfvVE0OQJtKRwkp+3lMhYz6dO9bkcE/7p3nD/hfnGsvMzZSCLKuEKFR1ss+U8SvnCMbUZXoscsjvA6LED3y+q+nxR0wdHS5jUqwXiTDnxUjCCYGmNbeIQBZEYh0dI6yQXXstlFDMOMwwVK5osUinZ7eejqA/bkdhVUBINsvi6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=sJHkD6db; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="sJHkD6db"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86dd69a1b15so690684b3a.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 17:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790640729; x=1791245529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AbuNkQK/L+pg/yDlIMlRRHsYuQVsJSZCaklGdmmjYtU=;
        b=sJHkD6db9Hl0cXbcdtRCKhhsPfSO9fmYRqX5GRLK4j8nR0+DTuzr2Mj7x6DP9/fW8n
         53di/AhkvgywJT0vPb2I0GV5uWH2utXqiOUeZy8u67Efjpw7bGBhWTSgTsYqeEWkOQWu
         w1tf39UuSuNzKaLwGRD2UhpgRdL9/Ic5eimGDp73MSQhQADa0oGPiy1PHvjlHrNTVYdA
         +s/l3G+KRhM+YztLF0Mn6F9XOtUp7e3qcEjc25CmmaC9l3sHgoGsy7051D4+tdeWCUND
         qbh1lZELulCXP19zdlIFR8YUeED3RbGK+6NAhbU30FZ4YmHFyZs36DEsc2udPLhH7yRe
         Gw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790640729; x=1791245529;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AbuNkQK/L+pg/yDlIMlRRHsYuQVsJSZCaklGdmmjYtU=;
        b=AY9jAbqnkngd/t16N4rFm92xPxQ9bq9+97fnkGOLQCVgLJ5ElsUwU5UL/xKovgxr9Q
         +9gEX7A1qmnldbejM722VeRn4Jco3y7THJBKxHKpwRzadMoc+lOoPmp3nSa0m8RvADgv
         nZGr0NiqJSghYJFDn16nesRAsfFRYTFkMgOAblhYxzd4PvXkAzSpIiU9+3O1IfmZFyMQ
         NoK/CRXmUnngUPawZiknXramgac3kBRW42kjLQ8v4c/q/Y2g/i7HqfgRqX7BAeZBlNpZ
         HITFFsOHEqZvk0/oYK6zw1i1r8JcrLvHBm7YhM9b1+dB4+cqAw14q82f8clN9I6OJsh+
         TAug==
X-Gm-Message-State: AFuF++mTj7vPkTpJM51pF7nL34YDw7snTk9IQh61ie7OZDqd6OMYkmNb
	JIEf24iJlJGFSloP0L2kbQrM1yPSlOrYR2/Ekzku0PBc9euHGxoGGXTRwn8vA6IZ76A=
X-Gm-Gg: AYBFou03oepst0yiSMkEN+4TRE5rIpYG2QdKtqvo0cVgOqQvPWQ0AbkixW4rLGTch/K
	3XsjZNej5YCvbpglKYCX2O1X7usPBZz+9+vzWknfWeqtI2tzR7XWBiMTFlqi3DIsywwV9a0Xq9P
	vhlEC3BMCcHFTwplH/j6748v7beENMkcyEVNwWGabOfkrFpCX7Iub47nPWqsOO34owGUJci0fjG
	kXa+FL12lhfVnm2CQIklvewmJL3ButNtD+gO372ZmR3o1RBA/X7Obe6zybOnFyOfuBv8/kluSlZ
	Q/rqzofmc0Ltk7mNHmrNjVWq9XjC7Xqk747iBEB5RbVRRGogGpElThqT89pvZE6Zt8M/R5nL5bz
	0ZwK1RGuU4t7+DlcvT1iOXufcp3rOb/3Qpk2M1r3Dj+zzr9Mal5xuKChY09d5OmG/JU4UkF37oS
	6Y9pwu52MqeCYAJ9icMVnpROuI8MgKhr4SLR1bUgxPZrBRXkqIY98z6RQGwfd3J7SI7piS33JLC
	VQCgSJEabgI
X-Received: by 2002:a05:6a21:6e8f:b0:3de:4a1c:a93 with SMTP id adf61e73a8af0-3de7cc0d205mr659922637.28.1790640729533;
        Mon, 28 Sep 2026 17:12:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:51::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8800974cdc3sm4708243b3a.6.2026.09.28.17.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 17:12:09 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:12:08 -0700
From: Joe Damato <joe@dama.to>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: netdev@vger.kernel.org, radhey.shyam.pandey@amd.com,
	michal.simek@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	daniel@iogearbox.net
Subject: Re: [PATCH net] net: axienet: free outstanding TX buffers in
 axienet_dma_bd_release()
Message-ID: <arsCWFmUhSYkhcCv@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Sagi Maimon <maimon.sagi@gmail.com>, netdev@vger.kernel.org,
	radhey.shyam.pandey@amd.com, michal.simek@amd.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	daniel@iogearbox.net
References: <20260927081034.350422-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927081034.350422-1-maimon.sagi@gmail.com>

On Sun, Sep 27, 2026 at 11:10:34AM +0300, Sagi Maimon wrote:

[...]
 
> Walk the TX ring the way axienet_dma_err_handler() already does: unmap
> every descriptor whose cntrl is still set - axienet_free_tx_chain()
> clears it on reclaim - and free any skb still attached.

The code added in this patch and in axienet_dma_err_handler are almost
identical (as your commit message suggests). I am wondering if it's possible
to factor this code out into a helper and instead call it from both places
instead of repeating the same code?
