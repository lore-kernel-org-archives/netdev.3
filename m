Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9160A19E839
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 04:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787631466; cv=none; b=BbjeBgo7zPDaCM9iG7K1Kc/z/gBiJU7i/ZgCSy4TOmE5yYpjmwoRp4zCYsm22V5DI9+ZXjOIymVVYxHZbJPPYvbq3dmERtej8yDkOX59kkg9sXeUPxrc9qVgmX/EbJz9BWNmKGIJ9WQ3vBuF10mWuhEmfMwWxahf5QEikKcvbr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787631466; c=relaxed/simple;
	bh=Y/LQ9QUzVJau31l/U7V390n8iZaDBGfOee9VFpzvhhw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3nIumI2nvuujxsa0d0kZTIl15IsfnVls2VsQKE1VujCwhjWcAkN0nl4DW3V9uPVS50AxtbmcblGHZ9RzumECHhMH4+j8CoOhXDabFQwiy2GhiAxRhHhuhYueiH9GYahNVDHgBFveJQ30L1BgziKXOdGiwVvYJjGDbTWmX2R7l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=O/8gCMIy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="O/8gCMIy"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d6efd73032so1143525ad.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 21:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787631464; x=1788236264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XKarJQ7v4knMK/2oTM7TFn9XyjAlR/5IO2Gpes7WPQE=;
        b=O/8gCMIyJCIsoFoCDXUXB5T84yKaJ+mr3fvn+ymX+JUlilwzrq/pbY+144C/dkEQc0
         4DsEMLK7n9Shn9QnAMIMqwoE8dOYjrq3UEfUdqjcNrUW3CQ8aCJn1JR245JMrG3X+Hz6
         zmOQYQMrZYzwlCwcX20zNBhDNUkH+4iJoeLJVcmJPUj43sVb/QRrz0UNPKJs+HlcXISc
         WI0Euix0GeWCvRq9zYd9K0pHY5mbRJdgEa4fXKJUiE5Rz/AJotvFzwSwxqRJbeCvIdqY
         xwxgOWmjN72f8hX2aZDWDpKFRr57YiNFnVEKiqw4fbf+3MHRDi6yOKu1h6hIwqKZJyWV
         /xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787631464; x=1788236264;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKarJQ7v4knMK/2oTM7TFn9XyjAlR/5IO2Gpes7WPQE=;
        b=ZCZ9mV9sNspBngRk5ZqQISjz+JJkulNH2Yxq7HjKVeXGGVvGqAllfKJ8w4WKRT7HEj
         U1NJBACpVSTNhdGhr3IO5jINyt8o/AwN+Tu6ERFEhNW9jZWbnffcEcyGim844HYaWnRs
         +y62PJwfluHepg7g6ODMtqMhENd+LYPx29kr+m3MUa30/rk+XHYrTBetlNHB9X4zmQgq
         W+6ufKEzhlKhIEk0r78hdaheD7WAPlLiqWp0Lewp34d8tAKVTcNR1U9las6rYIuZctK4
         beyS9FvIH1alpAHyh4VymO0jEvXLoSIBOKw8lpMENgv/UF45gUeLpHGzN/l5Q2ONrKXT
         sGtQ==
X-Forwarded-Encrypted: i=1; AHgh+RoWz069a4E9qDInkAAG436aCy0wLW1nth6KazxGb2S7jM4uxyEI9WMl7wGGr6WMvBqbbZIXKr4=@vger.kernel.org
X-Gm-Message-State: AFuF++mPVO0tbPHHWA+HCMICKlml7awTEQ/Ql1ZcWHs0oggGaGp6wWWl
	YCzWMdBRQuYB4VhhKV8/fJNVu7NyEmKN/2XkibY0pni3w3aHuVEERU2lTHrLuNMgLu/s1GC7tgD
	bhmtE
X-Gm-Gg: AR+sD10XVakbJjrS96B5ECRsXhjx09ONkhD4uHwKJFO8zKCAkO+gt8MDH0GcKsVMiRf
	qua/JygP7G0bQrGc/NJzSrXWyOP9mkmind68HGrrcGXxI5EH/BwLw4EvSmTTHqDXyEuQ+uAzhiY
	sTZS61ImPds4lq7FEYXJ6NoKcnfpLhGWLLt6X69EO+NMeHr5AM88nWSpf+3ocEyL9jLUUDOQ/6t
	yJtjOdt/aiw7TDlrUgy9XibPr1rrUDxZWUe/P9usF0l5ShRdDIKjv6JmxO9Mi3z66G1RD7dpySk
	wKRKMR7jc7lBq+2pwh4XshKzaVWAVCCPYaoQKO4/5nVwkNWI/IKm40rJOA1XHEYC7MKO6vG0yzb
	/huQ32a7X4jcaifofKi8psmzwK3/8Kb+Zxt+WUcuOOLk4aSMxqBPa20cL0RBNi22iADrA1MGKFk
	lpF0Vx5MwQZaJnPmLMjMoodyFoexv/sNX7VUxrbdAlbHS0rsogeQ72LP49bSlulOwSGGJGqNm39
	Ilu3i9Ae5azTw92bBPo/MQ9Qdw25w==
X-Received: by 2002:a17:90b:540d:b0:38d:eaed:4adb with SMTP id 98e67ed59e1d1-39645b66b45mr5426902a91.20.1787631463767;
        Mon, 24 Aug 2026 21:17:43 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141861732f8sm30143744c88.10.2026.08.24.21.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 21:17:43 -0700 (PDT)
Date: Mon, 24 Aug 2026 21:16:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 v2 1/2] ss: move lport and rport in struct
 sockstat from int to long
Message-ID: <20260824211628.41e464f5@phoenix.local>
In-Reply-To: <20260817-fix_vsock-v2-1-47e544221eae@redhat.com>
References: <20260817-fix_vsock-v2-0-47e544221eae@redhat.com>
	<20260817-fix_vsock-v2-1-47e544221eae@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 14:54:20 +0200
Luigi Leonardi <leonardi@redhat.com> wrote:

> Commit 012cb515 ("ss: change aafilter port from int to long (inode
> support)") widened aafilter.port to long so that unix socket inode
> numbers larger than INT_MAX can be used as port filter values, but left
> sockstat.lport and sockstat.rport as int. This means large u32 values
> (e.g. vsock ports or unix inodes > INT_MAX) are truncated on the
> socket-stat side, making the comparison against aafilter.port always
> fail.
> 
> Widen lport and rport to long and update the sscanf format specifiers
> in proc_parse_inet_addr() and unix_show() accordingly.
> 
> Fixes: 012cb515 ("ss: change aafilter port from int to long (inode support)")
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---

Applied to iproute2 but I had to fix the snprintf() warning and condense
the overly verbose AI slop of a commit message.
