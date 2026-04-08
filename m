Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3255D3D1CC3
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775657370; cv=none; b=BcxFdfT7Tn7ezfgne6GS3wKQrLfi5iXBATgQ+45pjGVHZG41gDm9/mYtK1QUja+ms9Y7dIBqnj4KDnI4e6V+323mHQHvQ8enYDBjlCwCzxjXAbfvvhRG3uUrQ2HCxyoHTl2Xw9laQuub5kDVqXlGoTXEAb3l8JRkBETg55Kz+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775657370; c=relaxed/simple;
	bh=Gze7bOKjsZXnXsJqz7bzfq8c25jxj/BMOuElaqk2OFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrwPcWm6AQvl/kVBI1n7yLTG7E/+O19fOMtyGBcORs8chXnI0i5cMhNVo7Dk4dF2gkfCrm6KcfjkXINYo76Q9jDFivnKMzL2gXZ1xiMr+VP4g/a/yd21bHH7/Mo6AXdr9QdSU1toPSkiO7r+aSwRs9LASM+6NZugAyX7bR4RFco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=UvddOKBu; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="UvddOKBu"
Received: from x1 (13.3.31.150.dy.iij4u.or.jp [150.31.3.13])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 638E9I4t057284
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 8 Apr 2026 23:09:19 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=bYzchrb2PJb1o1pVGTErHKK6Im21E7HDexP01h7Ldws=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1775657359; v=1;
        b=UvddOKBuf42IdroTWJsyDyQKYzZRTfDkYThL6stQ0Ibpp1q4Ti9T/39mTlbzGiNb
         E8q0Atfo1haypJpPBRofmN00JTS6tZx1Xh/xYhSb+JjnKkrRZ+L1kUB0iPa0v/NY
         93LEx+F7LWre+wfz8oKiIr2qxcLOeDjI7Xn3PhqeYizDzz3RiHH+yGhZ7cFIomgb
         3Eomxh4mnBr/OEpt7+KlDiRYD77cWAtMS5RMb9BkDgsg3NhxRUQVcy2VMkcOoOTd
         q1vm8CcEBSURWi7igzCyHM1fL/KYyII11oFtrsZAXj7GeZ621Ga6sPrtrvhHTbhz
         MEz1QjdnBIcK9jwqJ0dBoQ==
Date: Wed, 8 Apr 2026 23:09:18 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
        netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 7/8] ixgbe: use GFP_KERNEL
 in ixgbe_fcoe_ddp_setup()
Message-ID: <adZd5ZtEzUL_4Oz0@x1>
References: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
 <20260408131216.2662245-8-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408131216.2662245-8-aleksandr.loktionov@intel.com>

On 04/08 15:12, Aleksandr Loktionov wrote:
> ixgbe_fcoe_ddp_setup() is always called from process context (FCoE
> offload setup paths) and never from an atomic context.  Using GFP_ATOMIC

As I mentioned in v1, I don't think this path is non-atomic.

fc_exch_seq_send()
  fc_exch_alloc() # acquires ep->ex_lock (spinlock) internally
  fc_fcp_ddp_setup()
    lport->tt.ddp_setup() == fcoe_ddp_setup()
      .ndo_fcoe_ddp_setup() == ixgbe_fcoe_ddp_get()
        ixgbe_fcoe_ddp_setup()
  ...
  spin_unlock_bh(&ep->ex_lock);

So even if this runs in process context, it still appears to be in
atomic context while ep->ex_lock is held and also bh is disabled.
GFP_KERNEL still looks unsafe here for me.

If I'm misreading something, please let me know.
Thanks.
